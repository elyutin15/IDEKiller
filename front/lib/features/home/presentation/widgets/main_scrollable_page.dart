import 'dart:convert';
import 'dart:html';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:idekiller/core/utils/compiler_classes/loading_animation.dart';
import 'package:idekiller/core/utils/compiler_classes/run_text.dart';
import 'package:idekiller/core/utils/compiler_classes/text_box.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';
import 'package:idekiller/features/home/presentation/widgets/run_code_button.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class MainScrollablePage extends StatefulWidget {
  const MainScrollablePage({super.key});

  @override
  State<MainScrollablePage> createState() => _MainScrollablePageState();
}

class _MainScrollablePageState extends State<MainScrollablePage> {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final codeController = CodeController(
    patternMap: {
      r'".*"': const TextStyle(color: Colors.yellow),
      r'[ ][a-zA-Z0-9]+?\(': const TextStyle(color: Colors.green),
    },
    stringMap: {
      "void": const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      "print": const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    },
  );
  late Timer timer;
  late var isButtonDisabled = false;
  bool _load = false;
  bool _stop = false;

  void func() {
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
        builder: (BuildContext context, state) {
      codeController.text = state.code;
      codeController.selection = TextSelection.fromPosition(
          TextPosition(offset: codeController.text.length));
      return Container(
        color: const Color.fromARGB(255, 14, 22, 31),
        child: Row(
          children: [
            Expanded(
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
                            fontSize: state.fontSize,
                            color: Colors.white,
                          ),
                          controller: codeController,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 25,
                    child: RunCodeButton(),
                  ),
                ],
              ),
            ),
            const VerticalDivider(
                color: Color.fromARGB(255, 28, 40, 52), thickness: 6, width: 0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: RichText(
                      text: const TextSpan(
                          text: "Input Console",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ),
                  Expanded(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: RichText(
                            text: const TextSpan(
                                text: "Output Console",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!isButtonDisabled) {
                              return;
                            }
                            setState(() {
                              _load = false;
                              isButtonDisabled = false;
                              timer.cancel();
                              _stop = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.pink.shade400), //text (and icon)
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return Colors.grey.withOpacity(0.8);
                                }
                                return Colors.transparent;
                              },
                            ),
                          ),
                          child: const Stop(),
                        ),
                        const SizedBox(
                          width: 10,
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
    });
  }

  Future<void> sendRequest(
      String code, TextEditingController outputController) async {
    outputController.text = "";
    isButtonDisabled = true;
    _stop = false;
    var url = 'http://localhost:8080';
    timer = Timer.periodic(const Duration(milliseconds: 100),
        (Timer t) => getOutput(outputController));
    await http
        .post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "uuid": const Uuid().v4()
            },
            body: json.encode({
              "code": {"code": code, "language": "Java"},
              "input": {"words": ""}
            }))
        .then((http.Response response) {
      if (_stop == true) return;
      timer.cancel();
      var output = json.decode(response.body);
      outputController.text = output["output"];
      debugPrint("gfugfdg${outputController.text}");
      setState(() {
        _load = false;
      });
      isButtonDisabled = false;
    });
  }

  Future<void> getOutput(TextEditingController outputController) async {
    var url = 'http://localhost:8080/output';
    await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "uuid": const Uuid().v4(),
    }).then((http.Response response) {
      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.contentLength}");
      debugPrint(response.body);
      var output = json.decode(response.body);
      if (outputController.text != output["output"]) {
        outputController.text = output["output"];
      }
    });
  }
}