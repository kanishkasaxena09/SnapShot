import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RefreshableWrapper extends StatelessWidget {
  const RefreshableWrapper({super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primaryLight,
      backgroundColor: Theme.of(context).colorScheme.surface,
      strokeWidth: 2.5,
      onRefresh: onRefresh,
      child: child,
    );
  }
}

class SmartRefreshWidget extends StatefulWidget {
  const SmartRefreshWidget({super.key, required this.child, required this.onRefresh, this.enableRefresh = true});
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool enableRefresh;

  @override
  State<SmartRefreshWidget> createState() => _SmartRefreshWidgetState();
}

class _SmartRefreshWidgetState extends State<SmartRefreshWidget> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    await widget.onRefresh();
    if (mounted) setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableRefresh) return widget.child;
    return RefreshIndicator(
      color: AppColors.primaryLight,
      backgroundColor: Theme.of(context).colorScheme.surface,
      strokeWidth: 2.5,
      onRefresh: _handleRefresh,
      child: widget.child,
    );
  }
}
