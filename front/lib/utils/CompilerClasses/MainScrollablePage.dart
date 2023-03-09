import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/RunText.dart';
import 'package:idekiller/utils/CompilerClasses/TextEnvironment.dart';
import 'package:idekiller/utils/CompilerClasses/Titles.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';
import 'package:idekiller/utils/GlobalValues.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScrollablePage extends StatefulWidget {
  MainScrollablePage({Key? key}) : super(key: key);

  @override
  State<MainScrollablePage> createState() => _MainScrollablePageState();
}

class _MainScrollablePageState extends State<MainScrollablePage>
    with TickerProviderStateMixin {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final codeController = TextEditingController(
      text:
          "public class Main {\n   public static void main (String[] args) {\n        System.out.println(\"Hello, World\");\n    }\n}");
  late var isButtonDisabled = false;

  bool _load = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? SizedBox(
            child: LoadingAnimationWidget.threeArchedCircle(
              size: 30,
              color: const Color(0xFFEA3799),
            ),
          )
        : Container();
    return Container(
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
                        child: TextEnvironment(
                          textEditingController: codeController,
                        ),
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
                    child: TextEnvironment(
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
                      loadingIndicator,
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
