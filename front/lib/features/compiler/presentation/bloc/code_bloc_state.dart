sealed class CodeBlocState {
  final String code;
  final int fontSize;

  CodeBlocState(this.code, this.fontSize);
}

class CodeBlocStateInitial extends CodeBlocState {
  CodeBlocStateInitial(super.code, super.fontSize);

  CodeBlocStateInitial copyWith({String? code, int? fontSize}) {
    return CodeBlocStateInitial(
      code ?? this.code,
      fontSize ?? this.fontSize,
    );
  }
}
class CodeBlocStateLoading extends CodeBlocState {
  CodeBlocStateLoading(super.code, super.fontSize);
}

class CodeBlocStateLoaded extends CodeBlocState {
  CodeBlocStateLoaded(super.code, super.fontSize);
}

class CodeBlocStateError extends CodeBlocState {
  final String error;

  CodeBlocStateError(this.error) : super('', 0);
}
