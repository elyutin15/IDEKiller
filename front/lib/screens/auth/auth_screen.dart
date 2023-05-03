// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/login_controller.dart';
import 'package:idekiller/controllers/registration_controller.dart';
import 'package:idekiller/screens/auth/widgets/input_fields.dart';
import 'package:idekiller/screens/auth/widgets/submit_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegistrationController registrationController =
  Get.put(RegistrationController());

  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 40, 52),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
                  () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'IDEkiller',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: !isLogin.value ? Colors.blueAccent : Colors.white54,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: Text('Register'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.blueAccent : Colors.white54,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registrationController.nameController, 'Name'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registrationController.emailController, 'Phone number'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registrationController.passwordController, 'Password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => registrationController.registerRequest(),
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'Phone number'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'Password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => loginController.loginRequest(),
          title: 'Login',
        )
      ],
    );
  }
}