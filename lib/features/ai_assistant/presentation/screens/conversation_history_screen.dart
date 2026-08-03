import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../providers/ai_assistant_providers.dart';

class ConversationHistoryScreen extends ConsumerWidget {
  const ConversationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              final conv = ref.read(conversationListProvider.notifier).createConversation();
              ref.read(activeConversationProvider.notifier).setConversation(conv);
              context.push('${RouteNames.aiAssistant}/chat/${conv.id}');
            },
          ),
        ],
      ),
      body: conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No conversations yet', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Start a new chat with AI Assistant', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
              itemBuilder: (context, index) {
                final conv = conversations[index];
                return ListTile(
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: conv.mode.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(conv.mode.icon, color: conv.mode.color, size: 22),
                  ),
                  title: Text(
                    conv.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    conv.lastMessagePreview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                    onSelected: (value) {
                      if (value == 'delete') {
                        ref.read(conversationListProvider.notifier).deleteConversation(conv.id);
                      }
                    },
                  ),
                  onTap: () {
                    ref.read(activeConversationProvider.notifier).setConversation(conv);
                    context.push('${RouteNames.aiAssistant}/chat/${conv.id}');
                  },
                );
              },
            ),
    );
  }
}
