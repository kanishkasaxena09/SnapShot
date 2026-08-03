import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../ai_assistant/presentation/providers/ai_assistant_providers.dart';

class FloatingAIButton extends ConsumerWidget {
  const FloatingAIButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: onPressed ?? () {
        final conv = ref.read(conversationListProvider.notifier).createConversation();
        ref.read(activeConversationProvider.notifier).setConversation(conv);
        context.push('${RouteNames.aiAssistant}/chat/${conv.id}');
      },
      tooltip: 'Open AI Assistant',
      backgroundColor: AppColors.primaryLight,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.auto_awesome_rounded,
        color: Colors.white,
        size: 26,
      ),
    ).animate().scale(
          delay: 600.ms,
          duration: 400.ms,
          curve: Curves.easeOutBack,
        );
  }
}
