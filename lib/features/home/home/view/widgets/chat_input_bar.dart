import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';

class ChatInputBar extends StatelessWidget {
  final bool isTyping;
  final bool hasInput;
  final void Function(String) onChanged;
  final void Function(String) onSend;
  final void Function() onPressed;
  final TextEditingController controller;

  const ChatInputBar({
    super.key,
    required this.onSend,
    required this.isTyping,
    required this.hasInput,
    required this.onPressed,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        left: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        right: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
      ),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        border: Border(
          top: BorderSide(
            color: AppColors.primary(context),
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background(context),
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
                ),
                border: Border.all(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 1,
                  ),
                  color: AppColors.ring(context),
                ), // Gold border for input
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'اكتب سؤالك القانوني...',
                        hintStyle: TextStyle(
                          color: AppColors.mutedForeground(context),
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                          vertical: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      onChanged: onChanged,
                      onSubmitted: onSend,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          //Send Button
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 48),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 48),
            decoration: BoxDecoration(
              color:
                  hasInput
                      ? AppColors.primary(context)
                      : AppColors.primary(context).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Transform.flip(
                flipX: true,
                child: Icon(
                  LucideIcons.send,
                  color: Colors.white,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
