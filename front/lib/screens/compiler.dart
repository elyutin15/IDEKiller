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
          'public class Main { \n\tpublic static void main(String[] args) { \n\t\t'
          'System.out.println(\"Hello World\")\; \n\t} \n}\n');

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
        child: SingleChildScrollView(
          child: Opacity(
            opacity: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Online Compiler",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      child: LanguageDropdownButton(),
                    ),
                    Container(
                      child: SizedBox(width: 20,),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,0,10,0),
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
                const Divider(
                  color: Colors.black,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      controller: textController,
                      maxLines: null, //or null
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              "Compilation Language": GlobalValues.language
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