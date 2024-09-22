import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idekiller/utils/global_values.dart';
import 'package:http/http.dart' as http;

class TextBox extends StatefulWidget {
  final bool enable;
  final TextEditingController textEditingController;

  const TextBox(
      {super.key, required this.textEditingController, this.enable = true});

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
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        widget.textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.textEditingController.text.length));
      },
      child: TextField(
        onSubmitted: (value) {
          if (!widget.enable) {
            return;
          }
          sendRequest(value);
          debugPrint(value);
        },
        textInputAction: TextInputAction.done,
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

Future<void> sendRequest(String args) async {
  var url = 'http://localhost:8080/append';
  await http
      .post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "uuid": GlobalValues.uuid
          },
          body: json.encode({"words": args}))
      .then((http.Response response) {
    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.contentLength}");
    if (response.statusCode == 500) {
      sendRequest(args);
    }
    debugPrint(response.body);
  });
}
