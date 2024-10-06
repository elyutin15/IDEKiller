import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/auth/domain/repository/auth_repository.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_event.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitialState()) {
    on<SignInEvent>(_onSignIn);
  }

  void _onSignIn(
      SignInEvent event, Emitter<AuthState> emit) {
    _authRepository.login(email: event.email, password: event.password);
    emit(AuthSuccessState());
  }
}
