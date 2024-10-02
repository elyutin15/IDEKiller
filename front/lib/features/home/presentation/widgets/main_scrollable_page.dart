import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:idekiller/features/home/presentation/widgets/console.dart';
import 'package:idekiller/features/home/presentation/widgets/loading_animation.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';
import 'package:idekiller/features/home/presentation/widgets/run_code_button.dart';
import 'package:idekiller/features/home/presentation/widgets/stop_code_button.dart';
import 'dart:async';

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
                    color: Color.fromARGB(255, 28, 40, 52),
                    thickness: 6,
                    width: 0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        child: RichText(
                          text: const TextSpan(
                              text: "Input Console",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Console(
                            consoleType: ConsoleType.input,
                            readOnly: false,
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
                            const StopCodeButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            const LoadingAnimation(),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Console(
                            consoleType: ConsoleType.output,
                            readOnly: true,
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
}