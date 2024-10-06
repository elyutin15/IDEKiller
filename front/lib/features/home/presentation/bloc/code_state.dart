
import 'package:flutter/cupertino.dart';

@immutable
sealed class CodeState {
  final String code;
  final double fontSize;
  final String language;
  final String theme;


  const CodeState(this.code, this.fontSize, this.language, this.theme);
}

class CodeInitialState extends CodeState {
  const CodeInitialState(super.code, super.fontSize, super.language, super.theme);

  CodeInitialState copyWith({String? code, double? fontSize, String? language, String? theme}) {
    return CodeInitialState(
      code ?? this.code,
      fontSize ?? this.fontSize,
      language ?? this.language,
      theme ?? this.theme,
    );
  }
}
class CodeLoadingState extends CodeState {
  const CodeLoadingState(super.code, super.fontSize, super.language, super.theme);
}

class CodeLoadedState extends CodeState {
  final String response;
  const CodeLoadedState(super.code, super.fontSize, super.language, super.theme, this.response);
}

class CodeBlocStateError extends CodeState {
  final String error;

  const CodeBlocStateError(this.error) : super('', 0, "", "");
}
