import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:idekiller/utils/GlobalValues.dart';

class TextBox extends StatefulWidget {
  final bool reversible;
  final bool enable;
  final TextEditingController textEditingController;

  const TextBox(
      {Key? key,
      required this.textEditingController,
      this.enable = true,
      this.reversible = true})
      : super(key: key);


  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  var style = TextStyle(
    fontSize: GlobalValues.font,
    color: Colors.white,
  );


  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if(widget.reversible == true)
          return;
        widget.textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: widget.textEditingController.text.length));
      },
      child: TextField(
        readOnly: !widget.enable,
        style: TextStyle(
          fontSize: GlobalValues.font,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: GlobalValues.code,
          // hintStyle: TextStyle(
          //   color: Colors.blueAccent
          // )
        ),
        controller: widget.textEditingController,
        maxLines: null,
      ),
    );
  }
}
