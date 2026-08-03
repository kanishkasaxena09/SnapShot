import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class OtpField extends StatefulWidget {

  const OtpField({
    super.key,
    this.length = 6,
    required this.onChanged,
    this.onCompleted,
    this.autofocus = true,
    this.hasError = false,
  });
  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;
  final bool hasError;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    if (widget.autofocus && _focusNodes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes[0].requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _code;
    widget.onChanged(code);

    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 48,
          height: 56,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) => _onKeyEvent(index, event),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: AppTypography.headlineMedium(
                color: colorScheme.onSurface,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: widget.hasError
                        ? colorScheme.error
                        : colorScheme.outline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: widget.hasError
                        ? colorScheme.error
                        : colorScheme.primary,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(color: colorScheme.error),
                ),
                filled: true,
                fillColor: _focusNodes[index].hasFocus
                    ? colorScheme.primaryContainer.withValues(alpha: 0.1)
                    : colorScheme.surfaceContainerHighest,
              ),
              onChanged: (value) => _onDigitChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
