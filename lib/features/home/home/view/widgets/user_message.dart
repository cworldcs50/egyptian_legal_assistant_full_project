import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../chatbot/models/chat_message_model.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: EdgeInsets.only(
          bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24.0),
          top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16.0,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 12.0,
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.primary(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
            ),
            topRight: Radius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
            ),
            bottomLeft: Radius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
            ),
            bottomRight: Radius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4.0),
            ), // Tail on the right side for RTL
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 15,
            ),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
