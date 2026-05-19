import 'dart:async';
import 'dart:convert';
import 'home_states.dart';
import 'home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chatbot/models/citation_model.dart';
import '../../../../core/classes/error_model.dart';
import '../../chatbot/models/chat_message_model.dart';
import '../repository/local/home_view_local_data.dart';
import '../../../auth/repository/i_auth_repository.dart';
import '../../chatbot/repository/i_chatbot_repository.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../../core/database/chat_history_db.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final IChatbotRepository iChatbotRepository;
  final IAuthRepository iAuthRepository;
  StreamSubscription? _chatSubscription;

  HomeBloc({required this.iChatbotRepository, required this.iAuthRepository})
    : super(InitHomeState(welcomeMessage: HomeViewLocalData.welcomeMessage)) {
    on<SendWelcomeMessageEvent>(_onSendWelcomeMessage);
    on<SendMessageEvent>(_onSendMessage);
    on<TokenReceivedEvent>(_onTokenReceived);
    on<ErrorReceivedEvent>(_onErrorReceived);
    on<StreamCompletedEvent>(_onStreamCompleted);
    on<SignOutEvent>(_onSignOut);
    on<ChatTextChangedEvent>(_onChatTextChanged);
    on<LoadSessionEvent>(_onLoadSession);
    on<NewChatEvent>(_onNewChat);
  }

  bool isTyping = false;
  bool hasInput = false;
  String get userName {
    final name = SharedPreference.sharedPreferencesInstance.getString("userName");
    return (name == null || name.trim().isEmpty) ? "مستخدم" : name;
  }

  String get email {
    final mail = SharedPreference.sharedPreferencesInstance.getString("userEmail");
    return (mail == null || mail.trim().isEmpty) ? "لا يوجد بريد إلكتروني" : mail;
  }
  
  String currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
  final ChatHistoryDatabase _db = ChatHistoryDatabase.instance;

  final List<ChatMessage> messages = [];
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  final _messageStreamController =
      StreamController<List<ChatMessage>>.broadcast();
  Stream<List<ChatMessage>> get messageStream =>
      _messageStreamController.stream;

  void _onChatTextChanged(
    ChatTextChangedEvent event,
    Emitter<HomeStates> emit,
  ) {
    hasInput = event.text.trim().isNotEmpty;
    emit(ChatTextChangedState(hasInput));
  }

  Future<void> _onSendWelcomeMessage(
    SendWelcomeMessageEvent event,
    Emitter<HomeStates> emit,
  ) async {
    // Check if welcome message already exists to avoid duplication
    if (messages.any((m) => m.id == 'welcome_1')) return;

    final isServerUp = await iChatbotRepository.getServerStatus();
    if (isServerUp) {
      messages.add(
        ChatMessage(
          id: 'welcome_1',
          role: MessageRole.assistant,
          message: HomeViewLocalData.welcomeMessage,
          timestamp: DateTime.now(),
        ),
      );
      _messageStreamController.add(List.from(messages));
      emit(SuccessHomeState(messages: List.from(messages)));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<HomeStates> emit,
  ) async {
    final text = event.message.trim();
    if (text.isEmpty || isTyping) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    final assistantPlaceholder = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      message: '',
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );

    messages.add(userMessage);
    messages.add(assistantPlaceholder);
    isTyping = true;
    hasInput = false; // Reset hasInput on send
    textController.clear();
    _scrollToBottom();

    _messageStreamController.add(List.from(messages));
    emit(SuccessHomeState(messages: List.from(messages)));

    // Save user message to local DB
    await _db.insertMessage(currentSessionId, userMessage);

    await _chatSubscription?.cancel();
    _chatSubscription = iChatbotRepository
        .askQuestionStream(text, currentSessionId)
        .listen(
          (result) {
            result.fold(
              (failure) => add(ErrorReceivedEvent(failure.message)),
              (token) => add(TokenReceivedEvent(token)),
            );
          },
          onDone: () => add(StreamCompletedEvent()),
          onError: (e) => add(ErrorReceivedEvent(e.toString())),
        );
  }

  void _onTokenReceived(TokenReceivedEvent event, Emitter<HomeStates> emit) {
    if (messages.isEmpty) return;

    String token = event.token;
    // Strip "data: " prefix if present
    if (token.startsWith('data: ')) {
      token = token.substring(6);
    }

    if (token.isEmpty) return;

    final lastMessage = messages.last;
    if (lastMessage.role != MessageRole.assistant) return;

    // Handle metadata tokens
    if (token.startsWith('[SOURCES]:')) {
      final sourcesJson = token.substring(10);
      try {
        final List<dynamic> sourcesList = jsonDecode(sourcesJson);
        final citations =
            sourcesList
                .map(
                  (s) => Citation(
                    lawName: s['source'] ?? '',
                    articleNumber: 'مادة ${s['chunk_index'] ?? ''}',
                    text: s['preview'] ?? '',
                  ),
                )
                .toList();

        messages[messages.length - 1] = lastMessage.copyWith(
          citations: citations,
        );
      } catch (e) {
        debugPrint('Error parsing sources: $e');
      }
    } else if (token.startsWith('[TIME]:')) {
      // Ignore time metadata for now
    } else if (token == '[DONE]') {
      add(StreamCompletedEvent());
    } else {
      // It's a normal text token
      // Fix literal escapes sent by backend (\n, \")
      final formattedToken = token
          .replaceAll(r'\n', '\n')
          .replaceAll(r'\"', '"');
      messages[messages.length - 1] = lastMessage.copyWith(
        message: lastMessage.message + formattedToken,
      );
    }

    _messageStreamController.add(List.from(messages));
    emit(SuccessHomeState(messages: List.from(messages)));
    _scrollToBottom();
  }

  void _onErrorReceived(ErrorReceivedEvent event, Emitter<HomeStates> emit) {
    isTyping = false;
    emit(
      ErrorHomeState(
        errorModel: ErrorModel(title: "Error", message: event.message),
      ),
    );
    _chatSubscription?.cancel();
  }

  void _onStreamCompleted(
    StreamCompletedEvent event,
    Emitter<HomeStates> emit,
  ) async {
    isTyping = false;
    
    // Save assistant message and update session
    if (messages.isNotEmpty) {
      final lastMessage = messages.last;
      if (lastMessage.role == MessageRole.assistant) {
        await _db.insertMessage(currentSessionId, lastMessage);
        
        // Find the first user message for the title if it's a new session
        final userMsg = messages.firstWhere(
          (m) => m.role == MessageRole.user,
          orElse: () => lastMessage,
        );
        
        await _db.upsertSession(
          id: currentSessionId,
          title: userMsg.message.length > 30 
              ? '${userMsg.message.substring(0, 30)}...' 
              : userMsg.message,
          lastMessage: lastMessage.message.length > 50 
              ? '${lastMessage.message.substring(0, 50)}...' 
              : lastMessage.message,
          updatedAt: DateTime.now(),
        );
      }
    }

    _messageStreamController.add(List.from(messages));
    emit(SuccessHomeState(messages: List.from(messages)));
    _chatSubscription?.cancel();
  }

  Future<void> _onLoadSession(
    LoadSessionEvent event,
    Emitter<HomeStates> emit,
  ) async {
    currentSessionId = event.sessionId;
    messages.clear();
    final historyMessages = await _db.getMessagesForSession(currentSessionId);
    messages.addAll(historyMessages);
    
    _messageStreamController.add(List.from(messages));
    emit(SuccessHomeState(messages: List.from(messages)));
  }

  void _onNewChat(NewChatEvent event, Emitter<HomeStates> emit) {
    messages.clear();
    currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    _messageStreamController.add(List.from(messages));
    emit(SuccessHomeState(messages: List.from(messages)));
    add(SendWelcomeMessageEvent());
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<HomeStates> emit) async {
    final result = await iAuthRepository.logout();
    result.fold(
      (failure) {
        emit(
          FailureSignOutState(
            errorModel: ErrorModel(title: "Error", message: failure.message),
          ),
        );
      },
      (_) async {
        emit(SuccessSignOut());
        await iAuthRepository.setIsAuthorized(false);
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
