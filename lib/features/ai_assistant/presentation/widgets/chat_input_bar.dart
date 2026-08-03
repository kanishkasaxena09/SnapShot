import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.isStreaming,
    required this.onSend,
    required this.onVoiceTap,
    required this.onImageTap,
  });

  final TextEditingController controller;
  final bool isStreaming;
  final ValueChanged<String> onSend;
  final VoidCallback onVoiceTap;
  final VoidCallback onImageTap;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildActionButton(
            icon: Icons.image_rounded,
            onTap: widget.onImageTap,
            color: Colors.teal,
          ),
          const SizedBox(width: 4),
          _buildActionButton(
            icon: Icons.mic_rounded,
            onTap: widget.onVoiceTap,
            color: Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: widget.controller,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                enabled: !widget.isStreaming,
                decoration: InputDecoration(
                  hintText: widget.isStreaming ? 'AI is responding...' : 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(fontSize: 14),
                onSubmitted: (text) {
                  if (text.trim().isNotEmpty) widget.onSend(text);
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Material(
              color: _hasText && !widget.isStreaming
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _hasText && !widget.isStreaming
                    ? () => widget.onSend(widget.controller.text)
                    : null,
                child: Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  child: widget.isStreaming
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : Icon(
                          Icons.arrow_upward_rounded,
                          size: 20,
                          color: _hasText ? Colors.white : Colors.grey[500],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
