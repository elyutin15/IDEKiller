import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/Buttons.dart';
import 'package:idekiller/utils/CompilerClasses/DropdownButton.dart';
import 'package:idekiller/utils/CompilerClasses/Titles.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';
import 'package:idekiller/utils/GlobalValues.dart';
import 'package:idekiller/utils/CompilerClasses/TabIntent.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController liningController =
      TextEditingController(text: "1");
  final TextEditingController codeController = TextEditingController(
      text:
          "public class Main {\n   public static void main (String[] args) {\n        System.out.println(\"Hello, World\");\n    }\n}");
  bool isButtonDisabled = false;
  late AnimationController animationController;
  bool determinate = false;
  double dropdownValue = fonts[2];

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: false);
    animationController.stop();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                  const CompilerTitle(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<double>(
                      iconSize: 0,
                      dropdownColor: const Color.fromARGB(255, 28, 40, 52),
                      value: dropdownValue,
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (double? value) {
                        setState(() {
                          GlobalValues.font = value!;
                          debugPrint(GlobalValues.font.toString());
                          dropdownValue = value;
                        });
                      },
                      items:
                          fonts.map<DropdownMenuItem<double>>((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const LanguageDropdownButton(),
                  const SizedBox(
                    width: 20,
                  ),
                  const RegistrationPage(),
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
                                sendRequest(
                                    codeController.value.text,
                                    inputController.value.text,
                                    outputController,
                                    animationController);
                              },
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.grey.withOpacity(0.8);
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: const Text(
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
                        const InputTitle(),
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
                                padding: const EdgeInsets.only(left: 20),
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
                        Row(
                          children: [
                            const OutputTitle(),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.greenAccent,
                                  value: animationController.value,
                                ),
                              ),
                            ),
                          ],
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendRequest(
    String code,
    String input,
    TextEditingController outputController,
    AnimationController animationController,
  ) async {
    debugPrint('fgd');
    animationController.forward();
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
      animationController.value = 0;
    });
  }

}
