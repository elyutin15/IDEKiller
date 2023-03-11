import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';
import 'package:idekiller/utils/CompilerClasses/TabIntent.dart';

class TextEnvironment extends StatelessWidget {
  TextEditingController textEditingController;
  TextEnvironment({Key? key, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {InsertTabIntent: InsertTabAction()},
      child: Shortcuts(
        shortcuts: {
          LogicalKeySet(
            LogicalKeyboardKey.tab,
          ): InsertTabIntent(
            4,
            textEditingController,
          )
        },
        child: TextBox(
          textEditingController: textEditingController,
        ),
      ),
    );
  }
}
