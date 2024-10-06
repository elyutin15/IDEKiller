import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_event.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_state.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return switch (state) {
            AuthInitialState _ => TextButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(SignInEvent('email', 'password'));
                },
                child: Text('log in'),
              ),
            AuthSuccessState _ => Text('you successfully logged in'),
            AuthState() => throw Placeholder(),
          };
        },
      ),
    );
  }
}
