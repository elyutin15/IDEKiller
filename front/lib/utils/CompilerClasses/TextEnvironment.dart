import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';

class TextEnvironment extends StatelessWidget {
  final TextEditingController textEditingController;

  const TextEnvironment({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextBox(
      textEditingController: textEditingController,
    );
  }
}
