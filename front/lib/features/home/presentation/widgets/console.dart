import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

enum ConsoleType { input, output }

class Console extends StatefulWidget {
  final ConsoleType consoleType;
  final bool readOnly;

  const Console({super.key, required this.readOnly, required this.consoleType});

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context, state) {
        if (widget.consoleType == ConsoleType.output) {
          textEditingController.text = state.response;
        }
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event is RawKeyDownEvent &&
                event.isKeyPressed(LogicalKeyboardKey.enter)) {}
            if (event is RawKeyDownEvent &&
                event.isKeyPressed(LogicalKeyboardKey.backspace)) {}
          },
          child: TextField(
            readOnly: !widget.readOnly,
            style: TextStyle(
              fontSize: state.fontSize,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            controller: textEditingController,
            maxLines: null,
          ),
        );
      },
    );
  }
}
