import '../../bloc/home_bloc.dart';
import '../../bloc/home_events.dart';
import '../../bloc/home_states.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/typing_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../chatbot/models/chat_message_model.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../repository/local/home_view_local_data.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
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
          child: AdvancedDrawer(
            rtlOpening: true,
            disabledGestures: false,
            animateChildDecoration: true,
            animationCurve: Curves.easeInOut,
            controller: context.read<HomeBloc>().advancedDrawerController,
            backdropColor: AppColors.background(context),
            animationDuration: const Duration(milliseconds: 300),
            childDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
              ),
            ),
            drawer: SafeArea(
              child: Container(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0XFF222222)
                        : Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: AppColors.primary(context),
                      padding: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                        vertical: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 24,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed:
                                context
                                    .read<HomeBloc>()
                                    .advancedDrawerController
                                    .hideDrawer,
                            icon: const Icon(
                              HomeViewLocalData.x,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                bloc.userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                              Text(
                                bloc.email,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primaryReverse(context),
                            radius: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 20,
                            ),
                            child: const Icon(
                              HomeViewLocalData.user,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          vertical: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 8,
                          ),
                        ),
                        itemCount: HomeViewLocalData.drawerItems.length,
                        itemBuilder: (context, index) {
                          final item = HomeViewLocalData.drawerItems[index];
                          return DrawerItem(
                            icon: item.icon,
                            title: item.title,
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .advancedDrawerController
                                  .hideDrawer();
                              if (item.title == HomeViewLocalData.newChat) {
                                context.read<HomeBloc>().add(NewChatEvent());
                              } else {
                                Navigator.pushNamed(context, item.route);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                        vertical: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                      child: ListTile(
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
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        onTap: () {
                          context.read<HomeBloc>().add(SignOutEvent());
                          context
                              .read<HomeBloc>()
                              .advancedDrawerController
                              .hideDrawer();
                        },
                      ),
                    ),
                  ],
                ),

                // Logout
              ),
            ),
            child: Scaffold(
              backgroundColor: AppColors.background(context),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: AppColors.background(context),
                leadingWidth: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 70,
                ),
                toolbarHeight: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 70,
                ),
                leading: Padding(
                  padding: EdgeInsets.only(
                    right: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 16,
                    ),
                    top: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                    bottom: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary(context),
                    child: Icon(
                      HomeViewLocalData.user,
                      color: Colors.white,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  HomeViewLocalData.appTitle,
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 18,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary(context),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .advancedDrawerController
                          .showDrawer();
                    },
                    icon: Icon(
                      HomeViewLocalData.menu,
                      color: AppColors.primary(context),
                    ),
                  ),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1),
                  ),
                  child: Container(
                    color: AppColors.primary(context),
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 1,
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: LiquidPullToRefresh(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(SendWelcomeMessageEvent());
                      },
                      color: AppColors.primary(context),
                      backgroundColor: AppColors.card(context),
                      showChildOpacityTransition: false,
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
                                chatMessages.length + (bloc.isTyping ? 1 : 0),
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
                                          color: AppColors.foreground(context),
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
                  ),
                  ChatInputBar(
                    onChanged: (text) {
                      context.read<HomeBloc>().add(ChatTextChangedEvent(text));
                    },
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        SendMessageEvent(
                          message: context.read<HomeBloc>().textController.text,
                        ),
                      );
                    },
                    isTyping: context.read<HomeBloc>().isTyping,
                    hasInput: context.read<HomeBloc>().hasInput,
                    onSend: (message) {
                      context.read<HomeBloc>().add(
                        SendMessageEvent(message: message),
                      );
                    },
                    controller: context.read<HomeBloc>().textController,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
