import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idekiller/features/auth/presentation/login_screen.dart';
import 'package:idekiller/features/home/presentation/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);
