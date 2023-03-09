import 'package:flutter/material.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

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
          navigateToAnotherScreen(
            context,
            Routes.authentication,
          );
        },
      ),
    );
  }

  void navigateToAnotherScreen(BuildContext context, String page) async {
    await context.vxNav.push(Uri.parse(page));
  }
}

