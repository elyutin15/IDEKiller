import 'package:flutter/foundation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:idekiller/utils/AppPages.dart';
import 'package:idekiller/utils/AppRouterDelegate.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter/material.dart';


void main() {
  // works only when u compile as a desktop application

  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    setWindowTitle('Ide Killer');
    setWindowMinSize(const Size(1280, 720));
    Future<Null>.delayed(const Duration(seconds: 1), () {
      setWindowFrame(Rect.fromCenter(
          center: const Offset(1000, 500), width: 1280, height: 720));
    });
  }

  setPathUrlStrategy();
  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    routerDelegate: AppRouterDelegate(),
  ));
}
