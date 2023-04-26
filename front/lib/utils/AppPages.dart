import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:idekiller/screens/auth/auth_screen.dart';
import 'package:idekiller/screens/compiler.dart';
import 'package:idekiller/screens/userProfile.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:idekiller/screens/editUser.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homeRoute,
      page: () => const Home(),
    ),
    GetPage(
      name: Routes.authentication,
      page: () => AuthScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => EditProfilePage(),
    ),
  ];
}