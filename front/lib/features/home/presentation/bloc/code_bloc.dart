import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/compiler_classes/text_box.dart';
import 'package:idekiller/core/utils/initial_codes.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

class CodeBloc extends Bloc<CodeBlocEvent, CodeBlocState> {
  CodeBloc() : super(CodeBlocStateInitial("java", 16)) {
    on<CodeBlocEventLanguageChange>(_onLanguageChange);
    on<CodeBlocEventFontChange>(_onFontChange);
    on<CodeBlocEventRun>(_onCodeRun);

    add(CodeBlocEventLanguageChange("Java"));
  }

  void _onLanguageChange(
      CodeBlocEventLanguageChange event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(code: initialCodes[event.language]));
  }

  void _onFontChange(
      CodeBlocEventFontChange event, Emitter<CodeBlocState> emit) {
    emit((state as CodeBlocStateInitial).copyWith(fontSize: event.fontSize));
  }

  void _onCodeRun(
      CodeBlocEventRun event, Emitter<CodeBlocState> emit) {
    sendRequest(
        state.code);
    emit(CodeBlocStateLoading(state.code, state.fontSize));
  }
}
