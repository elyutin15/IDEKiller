sealed class CodeBlocEvent {}

class CodeBlocEventFetch extends CodeBlocEvent {}
class CodeBlocEventLanguageChange extends CodeBlocEvent {
  final String language;

  CodeBlocEventLanguageChange(this.language);
}

class CodeBlocEventFontChange extends CodeBlocEvent {
  final double fontSize;

  CodeBlocEventFontChange(this.fontSize);
}

class CodeBlocEventRun extends CodeBlocEvent {
}



