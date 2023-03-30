import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:idekiller/utils/CompilerClasses/TextBox.dart';
import 'package:idekiller/utils/CompilerClasses/TextBoxActions.dart';

class TextEnvironment extends StatefulWidget {
  TextEditingController textEditingController;
  bool reversible;

  TextEnvironment({Key? key, required this.textEditingController, required this.reversible})
      : super(key: key);

  @override
  State<TextEnvironment> createState() => _TextEnvironmentState();
}

class _TextEnvironmentState extends State<TextEnvironment> {

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {InsertTabIntent: InsertTabAction(), InsertEnterIntent: InsertEnterAction(), InsertBraceIntent: InsertBraceAction()},
      child: Shortcuts(
        shortcuts: {
          LogicalKeySet(
            LogicalKeyboardKey.tab,
          ): InsertTabIntent(
            4,
            widget.textEditingController,
          ),
          LogicalKeySet(
            LogicalKeyboardKey.enter,
          ): InsertEnterIntent(
            4,
            widget.textEditingController
          ),
          LogicalKeySet(
            LogicalKeyboardKey.bracketLeft
          ): InsertBraceIntent(
            widget.textEditingController
          )
        },
        child: TextBox(
          textEditingController: widget.textEditingController,
          reversible: widget.reversible,
        ),
      ),
    );
  }
}
