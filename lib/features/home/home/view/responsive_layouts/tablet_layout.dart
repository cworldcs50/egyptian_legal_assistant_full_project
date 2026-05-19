import '../../bloc/home_bloc.dart';
import '../../bloc/home_events.dart';
import '../../bloc/home_states.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indicator.dart';
import '../../../../../core/utils/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../chatbot/models/chat_message_model.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../../../core/services/service_locator.dart';
import '../../repository/local/home_view_local_data.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(SendWelcomeMessageEvent()),
      child: BlocConsumer<HomeBloc, HomeStates>(
        listener: (context, state) {
          if (state is ErrorHomeState) {
            AppUtils.showSnackBar(context, message: state.errorModel.message);
          }

          if (state is FailureSignOutState) {
            AppUtils.showSnackBar(context, message: state.errorModel.message);
          }

          if (state is SuccessSignOut) {
            Navigator.pushReplacementNamed(context, AppConstants.signInRoute);
          }
        },
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.background(context),
              body: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 300,
                          ),
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0XFF222222)
                                  : Colors.white,
                          child: Column(
                            children: [
                              Container(
                                color: AppColors.primary(context),
                                padding: EdgeInsets.all(
                                  AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 16,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          bloc.userName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          bloc.email,
                                          style: TextStyle(
                                            fontSize:
                                                AdaptiveLayout.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 10,
                                                ),
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 10,
                                          ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: AppColors.primaryReverse(
                                        context,
                                      ),
                                      child: const Icon(
                                        HomeViewLocalData.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      HomeViewLocalData.drawerItems.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        HomeViewLocalData.drawerItems[index];
                                    return DrawerItem(
                                      icon: item.icon,
                                      title: item.title,
                                      onTap: () {
                                        if (item.title ==
                                            HomeViewLocalData.newChat) {
                                          context
                                              .read<HomeBloc>()
                                              .add(NewChatEvent());
                                        } else {
                                          Navigator.pushNamed(
                                            context,
                                            item.route,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),

                              /// Logout
                              ListTile(
                                leading: Icon(
                                  HomeViewLocalData.logOutIcon,
                                  color: AppColors.primary(context),
                                  size: AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 20,
                                  ),
                                ),
                                title: Text(
                                  HomeViewLocalData.logout,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary(context),
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                                onTap:
                                    () => context.read<HomeBloc>().add(
                                      SignOutEvent(),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder<List<ChatMessage>>(
                            stream: bloc.messageStream,
                            initialData: bloc.messages,
                            builder: (context, snapshot) {
                              final chatMessages = snapshot.data ?? [];
                              return ListView.builder(
                                controller: bloc.scrollController,
                                padding: EdgeInsets.all(
                                  AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 16,
                                  ),
                                ),
                                itemCount:
                                    chatMessages.length +
                                    (bloc.isTyping ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == chatMessages.length) {
                                    return const TypingIndicator();
                                  }

                                  final message = chatMessages[index];

                                  if (message.id == 'welcome_1') {
                                    return Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 16,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          bottom:
                                              AdaptiveLayout.getResponsiveFontSize(
                                                context,
                                                fontSize: 24,
                                              ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AdaptiveLayout.getResponsiveFontSize(
                                              context,
                                              fontSize: 12,
                                            ),
                                          ),
                                          color: AppColors.card(context),
                                          border: Border.all(
                                            color: AppColors.primaryReverse(
                                              context,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: MarkdownBody(
                                          data: message.message,
                                          styleSheet: MarkdownStyleSheet(
                                            p: TextStyle(
                                              color:
                                                  AppColors.foreground(context),
                                              fontSize:
                                                  AdaptiveLayout.getResponsiveFontSize(
                                                    context,
                                                    fontSize: 14,
                                                  ),
                                              height: 1.5,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return ChatBubble(message: message);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  ChatInputBar(
                    hasInput: context.read<HomeBloc>().hasInput,
                    onChanged: (text) {
                      context.read<HomeBloc>().add(
                        ChatTextChangedEvent(text),
                      );
                    },
                    onPressed: () {},
                    onSend: (message) {
                      context.read<HomeBloc>().add(
                        SendMessageEvent(message: message),
                      );
                    },
                    isTyping: context.read<HomeBloc>().isTyping,
                    controller: context.read<HomeBloc>().textController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
