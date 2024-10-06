import 'package:flutter/material.dart';
import 'package:idekiller/features/auth/presentation/widgets/body.dart';
import 'package:idekiller/features/auth/presentation/widgets/login_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LoginAppbar(),
      body: Body(),
    );
  }
}
