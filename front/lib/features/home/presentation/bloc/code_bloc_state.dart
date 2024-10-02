sealed class CodeBlocState {
  final String code;
  final double fontSize;
  final String language;
  final String response;

  CodeBlocState(this.code, this.fontSize, this.language, this.response);
}

class CodeBlocStateInitial extends CodeBlocState {
  CodeBlocStateInitial(super.code, super.fontSize, super.language, super.response);

  CodeBlocStateInitial copyWith({String? code, double? fontSize, String? language, String? response}) {
    return CodeBlocStateInitial(
      code ?? this.code,
      fontSize ?? this.fontSize,
      language ?? this.language,
      response ?? this.response
    );
  }
}
class CodeBlocStateLoading extends CodeBlocState {
  CodeBlocStateLoading(super.code, super.fontSize, super.language, super.response);
}

class CodeBlocStateLoaded extends CodeBlocState {
  CodeBlocStateLoaded(super.code, super.fontSize, super.language, super.response);
}

class CodeBlocStateError extends CodeBlocState {
  final String error;

  CodeBlocStateError(this.error) : super('', 0, "", "");
}
