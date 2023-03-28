import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idekiller/utils/GlobalValues.dart';

class TextBox extends StatefulWidget {
  TextBox(
      {Key? key,
      required this.textEditingController,
      this.enable = true,
      this.reversible = true})
      : super(key: key);

  final bool reversible;
  final bool enable;
  final TextEditingController textEditingController;
  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  var style = TextStyle(
    fontSize: GlobalValues.font,
    color: Colors.white,
  );
  late String initialText;

  @override
  void initState() {
    if (!widget.reversible) {
      initialText = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (widget.reversible) {
          return;
        }
        if (event is RawKeyDownEvent &&
            event.isKeyPressed(LogicalKeyboardKey.enter)) {

          setState(() {
            initialText = widget.textEditingController.text;
          });

          debugPrint(initialText);
        }
        if (event is RawKeyDownEvent &&
            event.isKeyPressed(LogicalKeyboardKey.backspace)) {
          // debugPrint(widget.textEditingController.text);

          if (widget.textEditingController.text.length <= initialText.length) {
            setState(() {
              widget.textEditingController.text = initialText;
            });
          }
        }
        widget.textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: widget.textEditingController.text.length));

      },
      child: TextField(
        readOnly: !widget.enable,
        style: TextStyle(
          fontSize: GlobalValues.font,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        controller: widget.textEditingController,
        maxLines: null,
      ),
    );
  }
}
