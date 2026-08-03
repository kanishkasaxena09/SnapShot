import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class DetailNotFoundScreen extends StatelessWidget {
  const DetailNotFoundScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            Text('$title not found', style: AppTypography.titleMedium(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
