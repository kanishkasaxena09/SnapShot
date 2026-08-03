import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ai_assistant_providers.dart';

class ChatSettingsSheet extends ConsumerWidget {
  const ChatSettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(chatSettingsProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Chat Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildSwitchTile(
            title: 'Streaming Responses',
            subtitle: 'Show text as it\'s generated',
            value: settings.streamingEnabled,
            onChanged: (_) => ref.read(chatSettingsProvider.notifier).toggleStreaming(),
          ),
          _buildSwitchTile(
            title: 'Code Highlighting',
            subtitle: 'Highlight code syntax',
            value: settings.codeHighlighting,
            onChanged: (_) => ref.read(chatSettingsProvider.notifier).toggleCodeHighlighting(),
          ),
          _buildSwitchTile(
            title: 'Markdown Rendering',
            subtitle: 'Render markdown in responses',
            value: settings.markdownEnabled,
            onChanged: (_) => ref.read(chatSettingsProvider.notifier).toggleMarkdown(),
          ),
          const SizedBox(height: 16),
          Text('Font Size', style: Theme.of(context).textTheme.titleMedium),
          Slider(
            value: settings.fontSize,
            min: 12,
            max: 20,
            divisions: 8,
            label: settings.fontSize.round().toString(),
            onChanged: (value) => ref.read(chatSettingsProvider.notifier).setFontSize(value),
          ),
          const SizedBox(height: 16),
          Text('Response Length', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'concise', label: Text('Concise')),
              ButtonSegment(value: 'detailed', label: Text('Detailed')),
              ButtonSegment(value: 'comprehensive', label: Text('Full')),
            ],
            selected: {settings.responseLength},
            onSelectionChanged: (selected) {
              if (selected.isNotEmpty) {
                ref.read(chatSettingsProvider.notifier).setResponseLength(selected.first);
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}
