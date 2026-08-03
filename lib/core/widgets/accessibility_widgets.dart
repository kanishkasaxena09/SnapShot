import 'package:flutter/material.dart';

class AccessibilityWrapper extends StatelessWidget {
  const AccessibilityWrapper({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.tooltip,
    this.button = false,
    this.enabled = true,
  });
  final Widget child;
  final String? label;
  final String? hint;
  final String? tooltip;
  final bool button;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      tooltip: tooltip,
      button: button,
      enabled: enabled,
      child: child,
    );
  }
}

class AccessibleCard extends StatelessWidget {
  const AccessibleCard({super.key, required this.child, required this.label, this.onTap});
  final Widget child;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: child,
      ),
    );
  }
}

class AccessibleIcon extends StatelessWidget {
  const AccessibleIcon({super.key, required this.icon, required this.label, this.onTap, this.size, this.color});
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Icon(icon, size: size, color: color),
      ),
    );
  }
}

class SmartText extends StatelessWidget {
  const SmartText({super.key, required this.text, this.style, this.semanticsLabel, this.maxLines});
  final String text;
  final TextStyle? style;
  final String? semanticsLabel;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel ?? text,
      child: Text(text, style: style, maxLines: maxLines, overflow: maxLines != null ? TextOverflow.ellipsis : null),
    );
  }
}
