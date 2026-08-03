import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ai_assistant_entities.dart';
import '../providers/ai_assistant_providers.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/prompt_suggestions.dart';
import '../screens/chat_settings_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, this.conversationId});

  final String? conversationId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _isStreaming = false;
  String? _streamingMessageId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initConversation());
  }

  void _initConversation() {
    if (widget.conversationId != null) {
      ref.read(activeConversationProvider.notifier).loadConversation(widget.conversationId!);
    } else if (ref.read(activeConversationProvider) == null) {
      final conv = ref.read(conversationListProvider.notifier).createConversation();
      ref.read(activeConversationProvider.notifier).setConversation(conv);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isStreaming) return;

    final mode = ref.read(currentModeProvider);
    final settings = ref.read(chatSettingsProvider);

    ref.read(activeConversationProvider.notifier).addUserMessage(text.trim());
    _textController.clear();
    _scrollToBottom();

    setState(() => _isStreaming = true);

    final streamingMsg = ref.read(activeConversationProvider.notifier).addStreamingMessage();
    _streamingMessageId = streamingMsg.id;
    _scrollToBottom();

    final dataSource = ref.read(aiAssistantDataSourceProvider);
    final fullResponse = dataSource.generateAIResponse(text, mode);

    if (settings.streamingEnabled) {
      await _streamResponse(fullResponse);
    } else {
      ref.read(activeConversationProvider.notifier).updateStreamingMessage(
            streamingMsg.id,
            fullResponse,
            isDone: true,
          );
    }

    setState(() {
      _isStreaming = false;
      _streamingMessageId = null;
    });
    _scrollToBottom();

    final conv = ref.read(activeConversationProvider);
    if (conv != null && conv.messages.length == 2) {
      final title = text.length > 30 ? '${text.substring(0, 30)}...' : text;
      ref.read(conversationListProvider.notifier).deleteConversation(conv.id);
      final newConv = ref.read(conversationListProvider.notifier).createConversation(title: title, mode: mode);
      ref.read(activeConversationProvider.notifier).setConversation(newConv.copyWith(messages: conv.messages));
    }
  }

  Future<void> _streamResponse(String fullText) async {
    final completer = Completer<void>();
    String current = '';
    int index = 0;

    Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if (index >= fullText.length) {
        timer.cancel();
        completer.complete();
        return;
      }

      final chunkSize = min(3, fullText.length - index);
      current += fullText.substring(index, index + chunkSize);
      index += chunkSize;

      ref.read(activeConversationProvider.notifier).updateStreamingMessage(
            _streamingMessageId!,
            current,
          );
      _scrollToBottom();
    });

    await completer.future;
  }

  void _onSuggestionTap(PromptSuggestion suggestion) {
    ref.read(currentModeProvider.notifier).state = suggestion.mode;
    _sendMessage(suggestion.prompt);
  }

  @override
  Widget build(BuildContext context) {
    final conversation = ref.watch(activeConversationProvider);
    final messages = conversation?.messages ?? [];
    final settings = ref.watch(chatSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          conversation?.title ?? 'AI Assistant',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, size: 22),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: messages.length + (_isStreaming ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == messages.length) {
                        return const TypingIndicator();
                      }
                      return MessageBubble(
                        message: messages[index],
                        fontSize: settings.fontSize,
                        showCodeHighlighting: settings.codeHighlighting,
                      );
                    },
                  ),
          ),
          ChatInputBar(
            controller: _textController,
            isStreaming: _isStreaming,
            onSend: _sendMessage,
            onVoiceTap: () {},
            onImageTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final suggestions = ref.watch(promptSuggestionsProvider);
    final currentMode = ref.watch(currentModeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: currentMode.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(currentMode.icon, size: 48, color: currentMode.color),
          ),
          const SizedBox(height: 20),
          Text(
            'AI Assistant',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask me anything — code, career advice, resume review, and more.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          PromptSuggestions(
            suggestions: suggestions,
            onTap: _onSuggestionTap,
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ChatSettingsSheet(),
    );
  }
}
