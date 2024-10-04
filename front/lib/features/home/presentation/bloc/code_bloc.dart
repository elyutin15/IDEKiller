import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/code_snippets.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

class CodeBloc extends Bloc<CodeBlocEvent, CodeBlocState> {
  CodeBloc(this._responseRepository)
      : super(CodeBlocStateInitial(
            codeSnippets["java"]!, 16, "java", "a11y-dark")) {
    on<CodeBlocEventLanguageChange>(_onLanguageChange);
    on<CodeBlocEventFontChange>(_onFontChange);
    on<CodeBlocEventRun>(_onCodeRun);
    on<CodeBlocEventCodeChange>(_onCodeChange);
    on<CodeBlocEventThemeChange>(_onThemeChange);

    add(CodeBlocEventLanguageChange("java"));
  }

  void _onCodeChange(
      CodeBlocEventCodeChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(
        event.code, state.fontSize, state.language, state.theme));
  }

  void _onLanguageChange(
      CodeBlocEventLanguageChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(codeSnippets[event.language]!, state.fontSize,
        event.language, state.theme));
  }

  void _onThemeChange(
      CodeBlocEventThemeChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(
        state.code, state.fontSize, state.language, event.theme));
  }

  void _onFontChange(
      CodeBlocEventFontChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(
        state.code, event.fontSize, state.language, state.theme));
  }

  Future<void> _onCodeRun(
      CodeBlocEventRun event, Emitter<CodeBlocState> emit) async {
    emit(CodeBlocStateLoading(
        state.code, state.fontSize, state.language, state.theme));
    final response = await _responseRepository.getResponse(
        code: state.code, language: state.language, words: "");
    emit(CodeBlocStateLoaded(state.code, state.fontSize, state.language,
        state.theme, response.response));
  }

  final ResponseRepository _responseRepository;
}
