import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  const SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  const SignUpEvent(this.email, this.password);
}

