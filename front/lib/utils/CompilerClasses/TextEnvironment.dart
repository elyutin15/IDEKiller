import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';

class TextEnvironment extends StatefulWidget {
  TextEditingController textEditingController;

  TextEnvironment(
      {Key? key, required this.textEditingController})
      : super(key: key);

  @override
  State<TextEnvironment> createState() => _TextEnvironmentState();
}

class _TextEnvironmentState extends State<TextEnvironment> {
  @override
  Widget build(BuildContext context) {
    return TextBox(
      textEditingController: widget.textEditingController,
    );
  }
}
