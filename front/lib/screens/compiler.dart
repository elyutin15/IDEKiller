import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/utils/DropdownButton.dart';
import 'package:idekiller/utils/TextBox.dart';
import 'package:idekiller/GlobalValues.dart';
import 'package:idekiller/utils/TabIntent.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:path_icon/path_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController liningController =
      TextEditingController(text: "1");
  final TextEditingController codeController = TextEditingController(
      text:
          "public class Main {\n   public static void main (String[] args) {\n        System.out.println(\"Hello, World\");\n    }\n}");

  final iconData = PathIconData.fromData(
      '''M101.06 190.322C92.8024 173.178 85.5 152.417 85.5 129.5C85.5 106.583 92.8024 85.822 101.06 68.6779C107.292 55.7406 114.872 43.3794 120.869 33.5992C122.641 30.7104 124.274 28.0468 125.694 25.6601C126.025 25.1026 126.345 24.562 126.652 24.0377C69.7024 25.5472 24 72.1864 24 129.5C24 186.814 69.7024 233.453 126.652 234.962C126.345 234.438 126.025 233.897 125.694 233.34C124.274 230.953 122.641 228.29 120.869 225.401C114.872 215.621 107.292 203.259 101.06 190.322ZM132.946 247.654C132.943 247.653 132.927 247.592 132.907 247.476C132.939 247.598 132.949 247.656 132.946 247.654ZM132.946 11.3456C132.949 11.3441 132.939 11.4017 132.907 11.5235C132.927 11.4081 132.943 11.3472 132.946 11.3456ZM140.886 212.119C127.146 189.698 109.5 160.905 109.5 129.5C109.5 98.0954 127.146 69.3018 140.886 46.8812C158.438 18.241 169.616 0 129.5 0C57.9791 0 0 57.9791 0 129.5C0 201.021 57.9791 259 129.5 259C169.616 259 158.438 240.759 140.886 212.119Z''');

  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(255, 28, 40, 52),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Online Compiler",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const FontDropdownButton(),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    child: const LanguageDropdownButton(),
                  ),
                  Container(
                    child: const SizedBox(
                      width: 20,
                    ),
                  ),
                  Padding(
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
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.black,
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: const Color.fromARGB(255, 14, 22, 31),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Column(
                            children: [
                              Expanded(
                                child: Actions(
                                  actions: {InsertTabIntent: InsertTabAction()},
                                  child: Shortcuts(
                                    shortcuts: {
                                      LogicalKeySet(LogicalKeyboardKey.tab):
                                          InsertTabIntent(
                                        4,
                                        codeController,
                                      ),
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: TextBox(
                                        textEditingController: codeController,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 20,
                          child: SizedBox(
                            height: 32,
                            width: 76,
                            child: TextButton.icon(
                              style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(16),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[500]),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_isButtonDisabled) {
                                  return;
                                }
                                sendRequest(
                                  codeController.value.text,
                                  inputController.value.text,
                                  outputController,
                                );
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Run",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Color.fromARGB(255, 28, 40, 52),
                    thickness: 6,
                    width: 0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: RichText(
                            text: const TextSpan(
                                text: "Input Console",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Actions(
                            actions: {InsertTabIntent: InsertTabAction()},
                            child: Shortcuts(
                              shortcuts: {
                                LogicalKeySet(
                                  LogicalKeyboardKey.tab,
                                ): InsertTabIntent(
                                  4,
                                  inputController,
                                )
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: TextBox(
                                  textEditingController: inputController,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          thickness: 3,
                          color: Color.fromARGB(255, 28, 40, 52),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: RichText(
                            text: const TextSpan(
                                text: "Output Console",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextBox(
                              textEditingController: outputController,
                              enable: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendRequest(
      String code, String input, TextEditingController outputController) async {
    debugPrint("btn");
    _isButtonDisabled = true;
    var url = 'http://localhost:8080';
    var response = await http
        .post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "CompilationLanguage": GlobalValues.language
            },
            body: json.encode({
              "code": {"code": code},
              "input": {"words": input}
            }))
        .then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
      var output = json.decode(response.body);
      outputController.text = output["output"];
      _isButtonDisabled = false;
    });
  }

  void navigateToAnotherScreen(BuildContext context, String page) async {
    await context.vxNav.push(Uri.parse(page));
  }
}
