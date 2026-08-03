import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeBlock extends StatelessWidget {
  const CodeBlock({
    super.key,
    required this.code,
    this.language = '',
  });

  final String code;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF313244), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF181825),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                if (language.isNotEmpty)
                  Text(
                    language.toUpperCase(),
                    style: TextStyle(
                      color: _getLanguageColor(language),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Code copied!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy_rounded, size: 13, color: Colors.white54),
                      SizedBox(width: 4),
                      Text('Copy', style: TextStyle(color: Colors.white54, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: SelectableText.rich(
              _highlightCode(code, language),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.6,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getLanguageColor(String lang) {
    switch (lang.toLowerCase()) {
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'python':
        return const Color(0xFF3776AB);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'html':
        return const Color(0xFFE34F26);
      case 'css':
        return const Color(0xFF1572B6);
      case 'json':
        return const Color(0xFF292929);
      default:
        return const Color(0xFFA6ACCD);
    }
  }

  TextSpan _highlightCode(String code, String language) {
    final spans = <TextSpan>[];
    final keywords = _getKeywords(language);
    final pattern = RegExp(
      '(//.*|/\\*.*\\*/|\'[^\']*\'|"[^"]*"|\\b(${keywords.join("|")})\\b|\\b\\d+\\.?\\d*\\b)',
      multiLine: true,
    );

    int lastEnd = 0;
    for (final match in pattern.allMatches(code)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: code.substring(lastEnd, match.start)));
      }

      final text = match.group(0)!;
      if (text.startsWith('//') || text.startsWith('/*')) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: Color(0xFF6C7086))));
      } else if (text.startsWith("'") || text.startsWith('"')) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: Color(0xFFA6E3A1))));
      } else if (keywords.contains(text)) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: Color(0xFFCBA6F7), fontWeight: FontWeight.w500)));
      } else if (RegExp(r'^\d+\.?\d*$').hasMatch(text)) {
        spans.add(TextSpan(text: text, style: const TextStyle(color: Color(0xFFFAB387))));
      } else {
        spans.add(TextSpan(text: text));
      }
      lastEnd = match.end;
    }

    if (lastEnd < code.length) {
      spans.add(TextSpan(text: code.substring(lastEnd)));
    }

    return TextSpan(children: spans);
  }

  List<String> _getKeywords(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return ['import', 'class', 'extends', 'final', 'const', 'var', 'void', 'return', 'if', 'else', 'for', 'while', 'switch', 'case', 'break', 'continue', 'try', 'catch', 'throw', 'async', 'await', 'yield', 'static', 'abstract', 'override', 'required', 'late', 'get', 'set', 'new', 'factory', 'this', 'super', 'true', 'false', 'null'];
      case 'python':
        return ['def', 'class', 'import', 'from', 'return', 'if', 'else', 'elif', 'for', 'while', 'try', 'except', 'finally', 'with', 'as', 'lambda', 'yield', 'raise', 'pass', 'break', 'continue', 'True', 'False', 'None', 'self', 'async', 'await'];
      case 'javascript':
      case 'typescript':
        return ['const', 'let', 'var', 'function', 'return', 'if', 'else', 'for', 'while', 'do', 'switch', 'case', 'break', 'continue', 'try', 'catch', 'finally', 'throw', 'new', 'class', 'extends', 'import', 'export', 'default', 'async', 'await', 'yield', 'this', 'super', 'true', 'false', 'null', 'undefined'];
      default:
        return [];
    }
  }
}
