import 'package:flutter/material.dart';

class InsertTabIntent extends Intent {
  const InsertTabIntent(this.numSpaces, this.textController);

  final int numSpaces;
  final TextEditingController textController;
}

class InsertTabAction extends Action {
  @override
  Object invoke(covariant Intent intent) {
    if (intent is InsertTabIntent) {
      final oldValue = intent.textController.value;
      final newComposing = TextRange.collapsed(oldValue.composing.start);
      final newSelection = TextSelection.collapsed(
          offset: oldValue.selection.start + intent.numSpaces);

      final newText = StringBuffer(oldValue.selection.isValid
          ? oldValue.selection.textBefore(oldValue.text)
          : oldValue.text);
      for (var i = 0; i < intent.numSpaces; i++) {
        newText.write(' ');
      }
      newText.write(oldValue.selection.isValid
          ? oldValue.selection.textAfter(oldValue.text)
          : '');
      intent.textController.value = intent.textController.value.copyWith(
        composing: newComposing,
        text: newText.toString(),
        selection: newSelection,
      );
    }
    return '';
  }
}

class InsertEnterIntent extends Intent {
  const InsertEnterIntent(this.numSpaces, this.textController);

  final int numSpaces;
  final TextEditingController textController;
}

class InsertEnterAction extends Action {
  @override
  Object invoke(covariant Intent intent) {
    if (intent is InsertEnterIntent) {
      final oldValue = intent.textController.value;

      final newComposing = TextRange.collapsed(oldValue.composing.start);

      final newText = StringBuffer(oldValue.selection.isValid
          ? oldValue.selection.textBefore(oldValue.text)
          : oldValue.text);

      int cnt = 0;
      for (int i = 0; i < newText.toString().length; i++) {
        if (newText.toString()[i] == '{') cnt++;
        if (newText.toString()[i] == '}') cnt--;
      }

      final newSelection = TextSelection.collapsed(
          offset: oldValue.selection.start +
              (cnt == 0 ? 1 : cnt * intent.numSpaces + 1));

      debugPrint(newText.toString());
      newText.write('\n');
      for (var i = 0; i < cnt * intent.numSpaces; i++) {
        newText.write(' ');
      }
      newText.write(oldValue.selection.isValid
          ? oldValue.selection.textAfter(oldValue.text)
          : '');
      intent.textController.value = intent.textController.value.copyWith(
        composing: newComposing,
        text: newText.toString(),
        selection: newSelection,
      );
    }
    return '';
  }
}

