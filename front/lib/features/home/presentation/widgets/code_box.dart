import 'dart:math';

import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlight/languages/all.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_state.dart';

class CustomCodeBox extends StatefulWidget {
  const CustomCodeBox({super.key});

  @override
  State<CustomCodeBox> createState() => _CustomCodeBoxState();
}

class _CustomCodeBoxState extends State<CustomCodeBox> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      patternMap: {
        r"\B#[a-zA-Z0-9]+\b": TextStyle(color: Colors.red),
        r"\B@[a-zA-Z0-9]+\b": TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.blue,
        ),
        r"\B![a-zA-Z0-9]+\b":
            TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic),
      },
      stringMap: {
        "bev": TextStyle(color: Colors.indigo),
      },
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeState>(
      builder: (BuildContext context, CodeState state) {
        final length = _codeController!.selection.baseOffset;
        _codeController!.text = state.code;
        _codeController!.selection =
            TextSelection.fromPosition(TextPosition(offset: min(length, state.code.length)));
        _codeController!.language = allLanguages[state.language];
        return CodeField(
          controller: _codeController!,
          textStyle:
              TextStyle(fontFamily: 'SourceCode', fontSize: state.fontSize),
          maxLines: null,
          onChanged: (value) {
            context.read<CodeBloc>().add(CodeChangeEvent(value));
          },
        );
      },
    );
  }
}
