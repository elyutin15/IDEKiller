import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idekiller/utils/GlobalValues.dart';
import 'package:idekiller/utils/userPreferences.dart';

class SaveCodeButton extends StatelessWidget {
  const SaveCodeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: const Icon(
          Icons.accessible_forward,
          color: Colors.white,
        ),
        onPressed: () {
          sendRequest();
        },
      ),
    );
  }


  Future<void> sendRequest() async {
    var url = 'http://localhost:8080/save';
    await http
        .post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "code": {"code": GlobalValues.code},
          "userid": UserPreferences().myUser.id,
        }))
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
    });
    }

}

