import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/ai_assistant_entities.dart';
import 'markdown_renderer.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.fontSize = 14.0,
    this.showCodeHighlighting = true,
  });

  final ChatMessage message;
  final double fontSize;
  final bool showCodeHighlighting;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isUser ? 60 : 0,
          right: isUser ? 0 : 60,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.auto_awesome, size: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'AI Assistant',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isUser)
                    SelectableText(
                      message.content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        height: 1.5,
                      ),
                    )
                  else
                    MarkdownRenderer(
                      content: message.content,
                      fontSize: fontSize,
                      showCodeHighlighting: showCodeHighlighting,
                    ),
                ],
              ),
            ),
            if (message.isStreaming)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isUser)
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: message.content));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard'), duration: Duration(seconds: 1)),
                        );
                      },
                      child: Icon(Icons.copy_rounded, size: 14, color: Colors.grey[500]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
