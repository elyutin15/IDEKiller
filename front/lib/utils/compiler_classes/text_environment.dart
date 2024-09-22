import 'package:flutter/material.dart';
import 'package:idekiller/utils/compiler_classes/text_box.dart';
class TextEnvironment extends StatelessWidget {
  final TextEditingController textEditingController;

  const TextEnvironment({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextBox(
      textEditingController: textEditingController,
    );
  }
}
