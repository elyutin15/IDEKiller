import 'package:flutter/material.dart';
import 'package:idekiller/features/auth/presentation/widgets/login_layout.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Divider(height: 0, color: Colors.black),
        Expanded(
          child: LoginLayout(),
        ),
      ],
    );
  }
}
