import 'package:flutter/material.dart';

class RichTextHighlighter extends StatelessWidget {
  final String fullText;
  final List<String> highlightWords;
  final Color highlightColor;
  final Color defaultColor;
  final TextStyle? defaultStyle;
  final TextStyle? highlightStyle;

  RichTextHighlighter({
    required this.fullText,
    required this.highlightWords,
    this.highlightColor = Colors.red,
    this.defaultColor = Colors.black,
    this.defaultStyle,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (highlightWords.isEmpty) {
      return Text(fullText, style: defaultStyle);
    }

    // 找出所有需要高亮的位置
    List<TextSpan> spans = [];
    int currentIndex = 0;

    while (currentIndex < fullText.length) {
      bool found = false;

      for (String word in highlightWords) {
        if (word.isEmpty) continue;

        int wordIndex = fullText.indexOf(word, currentIndex);
        if (wordIndex == currentIndex) {
          // 添加普通文本（如果有）
          if (currentIndex < wordIndex) {
            spans.add(TextSpan(
              text: fullText.substring(currentIndex, wordIndex),
              style: defaultStyle ?? TextStyle(color: defaultColor),
            ));
          }

          // 添加高亮文本
          spans.add(TextSpan(
            text: word,
            style: highlightStyle ?? TextStyle(
              color: highlightColor,
              // fontWeight: FontWeight.bold,
            ),
          ));

          currentIndex = wordIndex + word.length;
          found = true;
          break;
        }
      }

      if (!found) {
        // 添加剩余文本
        spans.add(TextSpan(
          text: fullText.substring(currentIndex),
          style: defaultStyle ?? TextStyle(color: defaultColor),
        ));
        break;
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}