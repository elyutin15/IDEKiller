import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/initial_codes.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

class CodeBloc extends Bloc<CodeBlocEvent, CodeBlocState> {
  CodeBloc(this._responseRepository)
      : super(CodeBlocStateInitial(initialCodes["Java"]!, 16, "Java", "")) {
    on<CodeBlocEventLanguageChange>(_onLanguageChange);
    on<CodeBlocEventFontChange>(_onFontChange);
    on<CodeBlocEventRun>(_onCodeRun);

    add(CodeBlocEventLanguageChange(initialCodes["Java"]!, 16, "Java", ""));
  }

  void _onLanguageChange(
      CodeBlocEventLanguageChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(
        initialCodes[event.language]!, event.fontSize, event.language, ""));
  }

  void _onFontChange(
      CodeBlocEventFontChange event, Emitter<CodeBlocState> emit) {
    emit(CodeBlocStateInitial(
        initialCodes[event.language]!, event.fontSize, event.language, ""));
  }

  Future<void> _onCodeRun(
      CodeBlocEventRun event, Emitter<CodeBlocState> emit) async {
    emit(CodeBlocStateLoading(
        state.code, state.fontSize, state.language, state.response));
    final response = await _responseRepository.getResponse(
        code: event.code, language: event.language, words: event.words);
    emit(CodeBlocStateLoaded(
        state.code, state.fontSize, state.language, response.response));
  }

  final ResponseRepository _responseRepository;
}
