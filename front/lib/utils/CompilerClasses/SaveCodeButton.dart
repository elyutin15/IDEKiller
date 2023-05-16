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
          if (isAuthorized == true) {
            sendRequest();
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Column(
                  children: const [
                    Text(
                        "Please login to save snippet to your personal account"),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                  ],
                ),
                content: const Text(
                  "Login with",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: const Text(
                              "Email",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            color: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: const Text(
                              "Phone",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
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
              "userid": user!.id,
            }))
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
    });
  }
}
