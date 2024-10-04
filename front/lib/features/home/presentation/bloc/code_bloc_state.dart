sealed class CodeBlocState {
  final String code;
  final double fontSize;
  final String language;
  final String theme;


  CodeBlocState(this.code, this.fontSize, this.language, this.theme);
}

class CodeBlocStateInitial extends CodeBlocState {
  CodeBlocStateInitial(super.code, super.fontSize, super.language, super.theme);

  CodeBlocStateInitial copyWith({String? code, double? fontSize, String? language, String? theme}) {
    return CodeBlocStateInitial(
      code ?? this.code,
      fontSize ?? this.fontSize,
      language ?? this.language,
      theme ?? this.theme,
    );
  }
}
class CodeBlocStateLoading extends CodeBlocState {
  CodeBlocStateLoading(super.code, super.fontSize, super.language, super.theme);
}

class CodeBlocStateLoaded extends CodeBlocState {
  final String response;
  CodeBlocStateLoaded(super.code, super.fontSize, super.language, super.theme, this.response);
}

class CodeBlocStateError extends CodeBlocState {
  final String error;

  CodeBlocStateError(this.error) : super('', 0, "", "");
}
