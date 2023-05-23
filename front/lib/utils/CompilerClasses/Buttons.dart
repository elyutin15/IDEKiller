import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: const Icon(
          Icons.account_box,
          color: Colors.white,
        ),
        onPressed: () {
          // html.window.open('http://localhost:10010/authentication',"_blank");
          navigateToAnotherScreen(
            Routes.authentication,
          );
        },
      ),
    );
  }

  void navigateToAnotherScreen(String page)  {
    Get.rootDelegate.toNamed(page);
  }
}

