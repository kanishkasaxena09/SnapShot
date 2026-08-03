import 'package:flutter/material.dart';

enum MessageRole { user, assistant, system }

enum AIResponseType { text, code, markdown, mixed }

enum AIAssistantMode {
  general('General', Icons.chat_rounded, Color(0xFF6C5CE7)),
  resumeAnalysis('Resume Analysis', Icons.description_rounded, Color(0xFF00B894)),
  githubAnalysis('GitHub Analysis', Icons.code_rounded, Color(0xFF0984E3)),
  careerGuidance('Career Guidance', Icons.trending_up_rounded, Color(0xFFE17055)),
  learningRoadmap('Learning Roadmap', Icons.school_rounded, Color(0xFFFDCB6E));

  const AIAssistantMode(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.isStreaming = false,
    this.responseType = AIResponseType.text,
    this.metadata,
  });

  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;
  final bool isStreaming;
  final AIResponseType responseType;
  final Map<String, dynamic>? metadata;

  ChatMessage copyWith({
    String? content,
    bool? isStreaming,
    AIResponseType? responseType,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id,
      role: role,
      content: content ?? this.content,
      timestamp: timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
      responseType: responseType ?? this.responseType,
      metadata: metadata ?? this.metadata,
    );
  }
}

class Conversation {
  const Conversation({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.mode = AIAssistantMode.general,
  });

  final String id;
  final String title;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AIAssistantMode mode;

  int get messageCount => messages.length;

  String get lastMessagePreview {
    if (messages.isEmpty) return '';
    final last = messages.last.content;
    return last.length > 80 ? '${last.substring(0, 80)}...' : last;
  }

  Conversation copyWith({
    String? title,
    List<ChatMessage>? messages,
    DateTime? updatedAt,
    AIAssistantMode? mode,
  }) {
    return Conversation(
      id: id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mode: mode ?? this.mode,
    );
  }
}

class ChatSettings {
  const ChatSettings({
    this.streamingEnabled = true,
    this.codeHighlighting = true,
    this.markdownEnabled = true,
    this.fontSize = 14.0,
    this.responseLength = 'detailed',
  });

  final bool streamingEnabled;
  final bool codeHighlighting;
  final bool markdownEnabled;
  final double fontSize;
  final String responseLength;

  ChatSettings copyWith({
    bool? streamingEnabled,
    bool? codeHighlighting,
    bool? markdownEnabled,
    double? fontSize,
    String? responseLength,
  }) {
    return ChatSettings(
      streamingEnabled: streamingEnabled ?? this.streamingEnabled,
      codeHighlighting: codeHighlighting ?? this.codeHighlighting,
      markdownEnabled: markdownEnabled ?? this.markdownEnabled,
      fontSize: fontSize ?? this.fontSize,
      responseLength: responseLength ?? this.responseLength,
    );
  }
}

class PromptSuggestion {
  const PromptSuggestion({
    required this.title,
    required this.prompt,
    required this.icon,
    required this.color,
    this.mode = AIAssistantMode.general,
  });

  final String title;
  final String prompt;
  final IconData icon;
  final Color color;
  final AIAssistantMode mode;
}
