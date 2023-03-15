import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/screens/compiler.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerRequest() async {
    var url = 'http://localhost:8080/registration';
    await http
        .post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text
        }))
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
    });
  }

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        'name': nameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          print(token);
          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString('token', token);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.off(Home());
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}