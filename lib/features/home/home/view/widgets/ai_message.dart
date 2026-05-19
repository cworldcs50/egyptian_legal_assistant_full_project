import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../chatbot/models/chat_message_model.dart';
import 'citation_box.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        margin: EdgeInsets.only(
          bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownBody(
              data: message.message,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: AppColors.foreground(context),
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 15,
                  ),
                  height: 1.6,
                  fontFamily: 'Cairo', // Ensure custom font applies
                ),
                strong: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary(context),
                  fontFamily: 'Cairo',
                ),
                h1: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
                h2: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 18,
                  ),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
                listBullet: TextStyle(
                  color: AppColors.foreground(context),
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            if (message.citations != null && message.citations!.isNotEmpty) ...[
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              ...message.citations!.map(
                (citation) => Padding(
                  padding: EdgeInsets.only(
                    bottom: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                  child: CitationBox(citation: citation),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
