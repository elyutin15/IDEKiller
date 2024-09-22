import 'package:flutter/material.dart';
import 'package:idekiller/utils/routes.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
          navigateToAnotherScreen(
            Routes.authentication,
          );
        },
      ),
    );
  }

  void navigateToAnotherScreen(String page) {
    // Get.rootDelegate.toNamed(page);
  }
}
