import 'dart:convert';
import 'package:code_text_field/code_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/LoadingAnimation.dart';
import 'package:idekiller/utils/CompilerClasses/RunText.dart';
import 'package:idekiller/utils/CompilerClasses/TextEnvironment.dart';
import 'package:idekiller/utils/CompilerClasses/Titles.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';
import 'package:idekiller/utils/GlobalValues.dart';

class MainScrollablePage extends StatefulWidget {
  const MainScrollablePage({Key? key}) : super(key: key);

  @override
  State<MainScrollablePage> createState() => _MainScrollablePageState();
}

class _MainScrollablePageState extends State<MainScrollablePage> {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final codeController = CodeController(
      patternMap: {
        r'".*"': const TextStyle(color: Colors.yellow),
        r'[a-zA-Z0-9]+\(.*\)': const TextStyle(color: Colors.green),
      },
      stringMap: {
        "void": const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        "print": const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      },
      text: GlobalValues.code,
  );

  late var isButtonDisabled = false;
  bool _load = false;

  void func() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    codeController.text = GlobalValues.code;
    codeController.selection = TextSelection.fromPosition(TextPosition(offset: codeController.text.length));
    return Container(
      color: const Color.fromARGB(255, 14, 22, 31),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned(
                  child: ListView(
                    children: [
                      CodeField(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 14, 22, 31),
                        ),
                        textStyle: TextStyle(
                          fontSize: GlobalValues.font,
                          // color: Colors.white,
                        ),
                        controller: codeController,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 25,
                  child: SizedBox(
                    height: 32,
                    width: 76,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isButtonDisabled) {
                          return;
                        }
                        setState(() {
                          _load = true;
                        });

                        GlobalValues.code = codeController.text;
                        sendRequest(codeController.value.text,
                            inputController.value.text, outputController);
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey.withOpacity(0.8);
                            }
                            return Colors.transparent;
                          },
                        ),
                      ),
                      child: const RunText(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
              color: Color.fromARGB(255, 28, 40, 52), thickness: 6, width: 0),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputTitle(),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextBox(
                      textEditingController: inputController,
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 6,
                  color: Color.fromARGB(255, 28, 40, 52),
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      const OutputTitle(),
                      const SizedBox(
                        width: 20,
                      ),
                      LoadingAnimation(
                        load: _load,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
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
    );
  }

  Future<void> sendRequest(
      String code, String input, TextEditingController outputController) async {
    outputController.text = "";
    isButtonDisabled = true;
    var url = 'http://localhost:8080';
    await http
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
      isButtonDisabled = false;
      setState(() {
        _load = false;
      });
    });
  }
}
