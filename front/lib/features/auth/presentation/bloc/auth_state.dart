import 'package:flutter/material.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {
  final String email;
  final String password;

  const AuthLoadingState(this.email, this.password);
}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String email;
  final String password;
  final String errorToShow;

  const AuthErrorState(this.email, this.password, this.errorToShow);
}
