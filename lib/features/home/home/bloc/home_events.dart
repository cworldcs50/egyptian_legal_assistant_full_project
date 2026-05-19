class HomeEvents {}

class SendWelcomeMessageEvent extends HomeEvents {}

class SendMessageEvent extends HomeEvents {
  final String message;
  SendMessageEvent({required this.message});
}

class SignOutEvent extends HomeEvents {}

class TokenReceivedEvent extends HomeEvents {
  final String token;
  TokenReceivedEvent(this.token);
}

class ErrorReceivedEvent extends HomeEvents {
  final String message;
  ErrorReceivedEvent(this.message);
}

class StreamCompletedEvent extends HomeEvents {}

class ChatTextChangedEvent extends HomeEvents {
  final String text;
  ChatTextChangedEvent(this.text);
}

class LoadSessionEvent extends HomeEvents {
  final String sessionId;
  LoadSessionEvent(this.sessionId);
}

class NewChatEvent extends HomeEvents {}

