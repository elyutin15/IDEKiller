import 'dart:convert';

import 'package:idekiller/utils/CompilerClasses/Buttons.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/screens/compiler.dart';
import 'package:http/http.dart' as http;
import 'package:idekiller/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginRequest() async {
    var url = 'http://localhost:8080/login';
    await http
        .post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": emailController.text,
          "password": passwordController.text
        }))
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      var out = response.body;
      debugPrint(out);
      if(out == "success"){
        debugPrint(out);
        const RegistrationPage().navigateToAnotherScreen(Routes.authentication);
      }
    });
  }

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          emailController.clear();
          passwordController.clear();
          Get.off(const Home());
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}