import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/initial_codes.dart';
import 'package:idekiller/features/compiler/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/compiler/presentation/bloc/code_bloc_state.dart';

class CodeBloc extends Bloc<CodeBlocEvent, CodeBlocState> {
  CodeBloc() : super(CodeBlocStateInitial("java", 16)) {
    on<CodeBlocEventLanguageChangeJava>(_onLanguageChangeJava);
    on<CodeBlocEventLanguageChangePython>(_onLanguageChangePython);
    on<CodeBlocEventLanguageChangeCpp>(_onLanguageChangeCpp);
    on<CodeBlocEventLanguageChangeC>(_onLanguageChangeC);

    add(CodeBlocEventLanguageChangeJava());
  }

  void _onLanguageChangeJava(
      CodeBlocEventLanguageChangeJava event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(code: initialCodes["Java"]));
  }

  void _onLanguageChangePython(
      CodeBlocEventLanguageChangePython event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(code: initialCodes["Python"]));
  }

  void _onLanguageChangeCpp(
      CodeBlocEventLanguageChangeCpp event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(code: initialCodes["Cpp"]));
  }

  void _onLanguageChangeC(
      CodeBlocEventLanguageChangeC event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(code:  initialCodes["C"]));
  }
}
