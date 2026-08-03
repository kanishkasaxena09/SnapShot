import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/ai_assistant_local_datasource.dart';
import '../../domain/entities/ai_assistant_entities.dart';
import 'package:flutter/material.dart';

final aiAssistantDataSourceProvider = Provider<AIAssistantLocalDataSource>((ref) {
  return AIAssistantLocalDataSource();
});

final conversationListProvider = NotifierProvider<ConversationListNotifier, List<Conversation>>(ConversationListNotifier.new);

class ConversationListNotifier extends Notifier<List<Conversation>> {
  AIAssistantLocalDataSource get _dataSource => ref.read(aiAssistantDataSourceProvider);

  @override
  List<Conversation> build() => _dataSource.getConversations();

  Conversation createConversation({String? title, AIAssistantMode mode = AIAssistantMode.general}) {
    final conv = _dataSource.createConversation(title: title ?? 'New Chat', mode: mode);
    state = _dataSource.getConversations();
    return conv;
  }

  void deleteConversation(String id) {
    _dataSource.deleteConversation(id);
    state = _dataSource.getConversations();
  }
}

final activeConversationProvider = StateNotifierProvider<ActiveConversationNotifier, Conversation?>((ref) {
  return ActiveConversationNotifier(ref);
});

class ActiveConversationNotifier extends StateNotifier<Conversation?> {
  ActiveConversationNotifier(this._ref) : super(null);

  final Ref _ref;

  AIAssistantLocalDataSource get _dataSource => _ref.read(aiAssistantDataSourceProvider);

  void setConversation(Conversation conversation) {
    state = conversation;
  }

  void loadConversation(String id) {
    state = _dataSource.getConversation(id);
  }

  void clear() {
    state = null;
  }

  ChatMessage addUserMessage(String content) {
    if (state == null) return _createDummyMessage(content);
    final message = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      role: MessageRole.user,
      content: content,
      timestamp: DateTime.now(),
    );
    state = state!.copyWith(
      messages: [...state!.messages, message],
      updatedAt: DateTime.now(),
    );
    _dataSource.updateConversation(state!);
    return message;
  }

  ChatMessage addStreamingMessage() {
    final message = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      isStreaming: true,
    );
    state = state!.copyWith(
      messages: [...state!.messages, message],
      updatedAt: DateTime.now(),
    );
    return message;
  }

  void updateStreamingMessage(String messageId, String content, {bool isDone = false}) {
    if (state == null) return;
    final messages = state!.messages.map((m) {
      if (m.id == messageId) {
        return m.copyWith(content: content, isStreaming: !isDone);
      }
      return m;
    }).toList();
    state = state!.copyWith(messages: messages, updatedAt: DateTime.now());
    if (isDone) {
      _dataSource.updateConversation(state!);
    }
  }

  ChatMessage _createDummyMessage(String content) {
    return ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      role: MessageRole.user,
      content: content,
      timestamp: DateTime.now(),
    );
  }
}

final chatSettingsProvider = NotifierProvider<ChatSettingsNotifier, ChatSettings>(ChatSettingsNotifier.new);

class ChatSettingsNotifier extends Notifier<ChatSettings> {
  @override
  ChatSettings build() => const ChatSettings();

  void toggleStreaming() => state = state.copyWith(streamingEnabled: !state.streamingEnabled);
  void toggleCodeHighlighting() => state = state.copyWith(codeHighlighting: !state.codeHighlighting);
  void toggleMarkdown() => state = state.copyWith(markdownEnabled: !state.markdownEnabled);
  void setFontSize(double size) => state = state.copyWith(fontSize: size);
  void setResponseLength(String length) => state = state.copyWith(responseLength: length);
}

final currentModeProvider = StateProvider<AIAssistantMode>((ref) => AIAssistantMode.general);

final promptSuggestionsProvider = Provider<List<PromptSuggestion>>((ref) {
  return const [
    PromptSuggestion(
      title: 'Resume Review',
      prompt: 'Analyze my resume and suggest improvements',
      icon: Icons.description_rounded,
      color: Color(0xFF00B894),
      mode: AIAssistantMode.resumeAnalysis,
    ),
    PromptSuggestion(
      title: 'GitHub Profile',
      prompt: 'Analyze my GitHub profile and give feedback',
      icon: Icons.code_rounded,
      color: Color(0xFF0984E3),
      mode: AIAssistantMode.githubAnalysis,
    ),
    PromptSuggestion(
      title: 'Career Advice',
      prompt: 'Guide me on my career path in tech',
      icon: Icons.trending_up_rounded,
      color: Color(0xFFE17055),
      mode: AIAssistantMode.careerGuidance,
    ),
    PromptSuggestion(
      title: 'Learning Path',
      prompt: 'Create a personalized learning roadmap for me',
      icon: Icons.school_rounded,
      color: Color(0xFFFDCB6E),
      mode: AIAssistantMode.learningRoadmap,
    ),
  ];
});
