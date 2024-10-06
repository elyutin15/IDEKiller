import 'package:flutter/cupertino.dart';

@immutable
sealed class CodeEvent {
  const CodeEvent();
}

class CodeChangeEvent extends CodeEvent {
  final String code;

  const CodeChangeEvent(this.code);
}

class CodeLanguageChangeEvent extends CodeEvent {
  final String language;

  const CodeLanguageChangeEvent(this.language);
}

class CodeThemeChangeEvent extends CodeEvent {
  final String theme;

  const CodeThemeChangeEvent(this.theme);
}

class CodeFontChangeEvent extends CodeEvent {
  final double fontSize;

  const CodeFontChangeEvent(this.fontSize);
}

class CodeRunEvent extends CodeEvent {}
