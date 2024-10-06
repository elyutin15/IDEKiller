import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:idekiller/core/internal/application.dart';
import 'package:idekiller/core/internal/dependencies/set_up.dart';
import 'package:idekiller/features/auth/domain/repository/auth_repository.dart';
import 'package:idekiller/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  setPathUrlStrategy();
  await setUp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => CodeBloc(GetIt.I<ResponseRepository>()),
        ),
        BlocProvider(
          create: (BuildContext context) => AuthBloc(GetIt.I<AuthRepository>()),
        ),
      ],
        child: const Application(),
    ),
  );
}
