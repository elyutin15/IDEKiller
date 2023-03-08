import 'package:flutter/material.dart';
import 'package:idekiller/utils/GlobalValues.dart';

class TextBox extends StatelessWidget {
  TextBox({Key? key, required this.textEditingController, this.enable = true})
      : super(key: key);

  final bool enable;
  final TextEditingController textEditingController;

  var style = TextStyle(
    fontSize: GlobalValues.font,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: !enable,
      style: TextStyle(
        fontSize: GlobalValues.font,
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      controller: textEditingController,
      maxLines: null,
    );
  }
}
