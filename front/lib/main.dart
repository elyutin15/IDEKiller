import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:idekiller/screens/userProfile.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter/material.dart';
import 'screens/compiler.dart';
import 'screens/auth/auth_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'utils/routes.dart';

void main() {

  //works only when u compile as a desktop application

  // WidgetsFlutterBinding.ensureInitialized();
  // if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS) {
  //     setWindowTitle('Ide Killer');
  //     setWindowMinSize(const Size(1280,720));
  //     Future<Null>.delayed(const Duration(seconds: 1), () {
  //       setWindowFrame(Rect.fromCenter(center: const Offset(1000, 500), width: 1280, height: 720));
  //     });
  // }

  setPathUrlStrategy();
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routeInformationParser: VxInformationParser(),
    routerDelegate: VxNavigator(routes: {
      Routes.homeRoute: (_, __) => MaterialPage(child: Home()),
      Routes.authentication: (_, __) => MaterialPage(child: AuthScreen()),
      //Routes.profile: (_, __) => MaterialPage(child: ProfilePage()),
    }),
  ));
}
