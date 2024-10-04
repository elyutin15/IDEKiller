sealed class CodeBlocEvent {}

class CodeBlocEventCodeChange extends CodeBlocEvent {
  final String code;

  CodeBlocEventCodeChange(this.code);
}

class CodeBlocEventLanguageChange extends CodeBlocEvent {
  final String language;

  CodeBlocEventLanguageChange(this.language);
}

class CodeBlocEventThemeChange extends CodeBlocEvent {
  final String theme;

  CodeBlocEventThemeChange(this.theme);
}


class CodeBlocEventFontChange extends CodeBlocEvent {
  final double fontSize;

  CodeBlocEventFontChange(this.fontSize);
}

class CodeBlocEventRun extends CodeBlocEvent {}
