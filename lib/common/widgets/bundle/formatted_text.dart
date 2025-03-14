import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String text;

  FormattedText(this.text);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    List<String> lines = text.split('\n'); // Разделяем текст на строки

    for (String line in lines) {
      if (line.trim().startsWith('**')) {
        // Обработка жирного текста
        textSpans.add(
          TextSpan(
            text: line.replaceAll('**', '') + '\n',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        );
      } else if (line.trim().startsWith('-')) {
        // Обработка маркированных списков
        textSpans.add(
          TextSpan(
            text: '• ${line.replaceFirst('-', '').trim()}\n',
            style: TextStyle(fontSize: 14),
          ),
        );
      } else {
        // Обычный текст
        textSpans.add(
          TextSpan(
            text: line + '\n',
            style: TextStyle(fontSize: 14),
          ),
        );
      }
    }

    return SelectableText.rich(
      TextSpan(children: textSpans),
    );
  }
}