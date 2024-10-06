import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/code_snippets.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';
import 'package:idekiller/features/home/presentation/bloc/code_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  CodeBloc(this._responseRepository)
      : super(CodeInitialState(
            codeSnippets["java"]!, 16, "java", "a11y-dark")) {
    on<CodeLanguageChangeEvent>(_onLanguageChange);
    on<CodeFontChangeEvent>(_onFontChange);
    on<CodeRunEvent>(_onCodeRun);
    on<CodeChangeEvent>(_onCodeChange);
    on<CodeThemeChangeEvent>(_onThemeChange);
  }

  void _onCodeChange(
      CodeChangeEvent event, Emitter<CodeState> emit) {
    emit(CodeInitialState(
        event.code, state.fontSize, state.language, state.theme));
  }

  void _onLanguageChange(
      CodeLanguageChangeEvent event, Emitter<CodeState> emit) {
    emit(CodeInitialState(codeSnippets[event.language]!, state.fontSize,
        event.language, state.theme));
  }

  void _onThemeChange(
      CodeThemeChangeEvent event, Emitter<CodeState> emit) {
    emit(CodeInitialState(
        state.code, state.fontSize, state.language, event.theme));
  }

  void _onFontChange(
      CodeFontChangeEvent event, Emitter<CodeState> emit) {
    emit(CodeInitialState(
        state.code, event.fontSize, state.language, state.theme));
  }

  Future<void> _onCodeRun(
      CodeRunEvent event, Emitter<CodeState> emit) async {
    emit(CodeLoadingState(
        state.code, state.fontSize, state.language, state.theme));
    final response = await _responseRepository.getResponse(
        code: state.code, language: state.language, words: "");
    emit(CodeLoadedState(state.code, state.fontSize, state.language,
        state.theme, response.response));
  }

  final ResponseRepository _responseRepository;
}
