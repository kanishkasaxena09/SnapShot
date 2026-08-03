import 'package:flutter/material.dart';

import 'code_block.dart';

class MarkdownRenderer extends StatelessWidget {
  const MarkdownRenderer({
    super.key,
    required this.content,
    this.fontSize = 14.0,
    this.showCodeHighlighting = true,
  });

  final String content;
  final double fontSize;
  final bool showCodeHighlighting;

  @override
  Widget build(BuildContext context) {
    final blocks = _parseBlocks(content);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        if (block is TextBlock) {
          return _buildTextBlock(context, block);
        } else if (block is CodeBlockData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: showCodeHighlighting
                ? CodeBlock(code: block.code, language: block.language)
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SelectableText(block.code, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 13)),
                  ),
          );
        } else if (block is HeaderBlock) {
          return _buildHeader(context, block);
        } else if (block is ListBlock) {
          return _buildList(context, block);
        } else if (block is TableBlock) {
          return _buildTable(context, block);
        } else if (block is QuoteBlock) {
          return _buildQuote(context, block);
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildTextBlock(BuildContext context, TextBlock block) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'(\*\*(.+?)\*\*|`(.+?)`)');
    int lastEnd = 0;

    for (final match in regex.allMatches(block.text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: block.text.substring(lastEnd, match.start)));
      }
      if (match.group(2) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(3) != null) {
        spans.add(WidgetSpan(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              match.group(3)!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: fontSize - 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ));
      }
      lastEnd = match.end;
    }

    if (lastEnd < block.text.length) {
      spans.add(TextSpan(text: block.text.substring(lastEnd)));
    }

    if (spans.isEmpty) {
      spans.add(TextSpan(text: block.text));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: SelectableText.rich(
        TextSpan(
          children: spans,
          style: TextStyle(
            fontSize: fontSize,
            height: 1.6,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HeaderBlock block) {
    final sizes = {1: 20.0, 2: 17.0, 3: 15.0};
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        block.text,
        style: TextStyle(
          fontSize: sizes[block.level] ?? 15,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, ListBlock block) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: block.items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${block.ordered ? "${block.items.indexOf(item) + 1}." : "•"} ',
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500)),
                Expanded(child: SelectableText(item, style: TextStyle(fontSize: fontSize, height: 1.5))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTable(BuildContext context, TableBlock block) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Table(
        border: TableBorder.all(color: Colors.grey[300]!, width: 0.5),
        children: block.rows.map((row) {
          return TableRow(
            children: row.map((cell) {
              final isHeader = block.rows.indexOf(row) == 0;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: isHeader ? BoxDecoration(color: Colors.grey[100]) : null,
                child: Text(cell, style: TextStyle(fontSize: fontSize - 1, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuote(BuildContext context, QuoteBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 3),
        ),
      ),
      child: Text(
        block.text,
        style: TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          color: Colors.grey[700],
          height: 1.5,
        ),
      ),
    );
  }

  List<dynamic> _parseBlocks(String content) {
    final blocks = <dynamic>[];
    final lines = content.split('\n');
    int i = 0;

    while (i < lines.length) {
      final line = lines[i];

      if (line.startsWith('```')) {
        final lang = line.substring(3).trim();
        final codeLines = <String>[];
        i++;
        while (i < lines.length && !lines[i].startsWith('```')) {
          codeLines.add(lines[i]);
          i++;
        }
        blocks.add(CodeBlockData(code: codeLines.join('\n'), language: lang));
        i++;
        continue;
      }

      if (line.startsWith('### ')) {
        blocks.add(HeaderBlock(text: line.substring(4), level: 3));
      } else if (line.startsWith('## ')) {
        blocks.add(HeaderBlock(text: line.substring(3), level: 2));
      } else if (line.startsWith('# ')) {
        blocks.add(HeaderBlock(text: line.substring(2), level: 1));
      } else if (line.startsWith('> ')) {
        blocks.add(QuoteBlock(text: line.substring(2)));
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        final items = <String>[];
        while (i < lines.length && (lines[i].startsWith('- ') || lines[i].startsWith('* '))) {
          items.add(lines[i].substring(2));
          i++;
        }
        blocks.add(ListBlock(items: items, ordered: false));
        continue;
      } else if (RegExp(r'^\d+\. ').firstMatch(line) != null) {
        final items = <String>[];
        while (i < lines.length && RegExp(r'^\d+\. ').firstMatch(lines[i]) != null) {
          items.add(lines[i].replaceFirst(RegExp(r'^\d+\. '), ''));
          i++;
        }
        blocks.add(ListBlock(items: items, ordered: true));
        continue;
      } else if (line.startsWith('|') && i + 1 < lines.length && lines[i + 1].startsWith('|')) {
        final rows = <List<String>>[];
        while (i < lines.length && lines[i].startsWith('|')) {
          final cells = lines[i].split('|').where((c) => c.trim().isNotEmpty).map((c) => c.trim()).toList();
          if (cells.isNotEmpty && !cells.every((c) => RegExp(r'^[-:]+$').hasMatch(c))) {
            rows.add(cells);
          }
          i++;
        }
        if (rows.isNotEmpty) {
          blocks.add(TableBlock(rows: rows));
        }
        continue;
      } else if (line.trim().isEmpty) {
        // skip blank lines
      } else {
        final textLines = <String>[];
        while (i < lines.length && lines[i].trim().isNotEmpty && !lines[i].startsWith('#') && !lines[i].startsWith('```') && !lines[i].startsWith('|') && !lines[i].startsWith('>') && !RegExp(r'^[\-\*\d]').hasMatch(lines[i])) {
          textLines.add(lines[i]);
          i++;
        }
        if (textLines.isNotEmpty) {
          blocks.add(TextBlock(text: textLines.join('\n')));
        }
        continue;
      }
      i++;
    }

    return blocks;
  }
}

class TextBlock {
  const TextBlock({required this.text});
  final String text;
}

class HeaderBlock {
  const HeaderBlock({required this.text, required this.level});
  final String text;
  final int level;
}

class CodeBlockData {
  const CodeBlockData({required this.code, required this.language});
  final String code;
  final String language;
}

class ListBlock {
  const ListBlock({required this.items, required this.ordered});
  final List<String> items;
  final bool ordered;
}

class TableBlock {
  const TableBlock({required this.rows});
  final List<List<String>> rows;
}

class QuoteBlock {
  const QuoteBlock({required this.text});
  final String text;
}
