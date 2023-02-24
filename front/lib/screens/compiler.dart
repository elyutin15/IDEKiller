import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/DropdownButton.dart';
import 'package:idekiller/GlobalValues.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TextEditingController textController = TextEditingController(
      text:
          "public class Main { public static void main (String[] args) { System.out.println(\"Hello, World\"); }}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF242387),
              Color(0xFFE94057),
              Color(0xFFF21221),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Online Compiler",
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                  Container(
                    child: const LanguageDropdownButton(),
                  ),
                  Container(
                    child: const SizedBox(
                      width: 20,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        navigateToAnotherScreen(context, Routes.authentication);
                        // debugPrint(textController.value.text);
                        // sendRequest(textController.value.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              flex: 10,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height - 66,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                controller: textController,
                                maxLines: null, //or null
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: const [
                          Expanded(flex: 1, child: Text("123")),
                          Divider(color: Colors.black,),
                          Expanded(flex: 1, child: Text("456")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendRequest(String string) async {
    var url = 'http://localhost:8080';
    var body = jsonEncode({'code': string});
    var response = await http
        .post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "CompilationLanguage": GlobalValues.language
            },
            body: body)
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
    });
  }

  void navigateToAnotherScreen(BuildContext context, String page) async {
    await context.vxNav.push(Uri.parse(page));
  }
}
