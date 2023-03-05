import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox(
      {Key? key, required this.textEditingController, this.enable = true})
      : super(key: key);

  final bool enable;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        readOnly: !enable,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        controller: textEditingController,
        maxLines: null,
      ),
    );
  }
}
