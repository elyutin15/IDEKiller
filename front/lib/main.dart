import 'screens/compiler.dart';
import 'package:flutter/material.dart';
import 'screens/auth/auth_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'utils/routes.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routeInformationParser: VxInformationParser(),
    routerDelegate: VxNavigator(routes: {
      Routes.homeRoute: (_, __) => MaterialPage(child: Home()),
      Routes.authentication: (_, __) => MaterialPage(child: AuthScreen()),
      // Routes.registrationRoute: (_, __) => const MaterialPage(child: RegistrationScreen())
    }),
  ));
}

