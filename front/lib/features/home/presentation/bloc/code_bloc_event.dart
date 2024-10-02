sealed class CodeBlocEvent {
  final String code;
  final double fontSize;
  final String language;
  final String words;

  CodeBlocEvent(this.code, this.fontSize, this.language, this.words);
}

class CodeBlocEventFetch extends CodeBlocEvent {
  CodeBlocEventFetch(super.code, super.fontSize, super.language, super.words);
}

class CodeBlocEventLanguageChange extends CodeBlocEvent {
  CodeBlocEventLanguageChange(super.code, super.fontSize, super.language, super.words);

}

class CodeBlocEventFontChange extends CodeBlocEvent {
  CodeBlocEventFontChange(super.code, super.fontSize, super.language, super.words);
}

class CodeBlocEventRun extends CodeBlocEvent {
  CodeBlocEventRun(super.code, super.fontSize, super.language, super.words);
}
