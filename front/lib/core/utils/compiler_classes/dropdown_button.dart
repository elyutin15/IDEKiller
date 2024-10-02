import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> languages = <String>['Java', 'C++', 'C', 'Python'];
const List<double> fonts = <double>[10, 12, 14, 16, 18, 20];

class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

  @override
  State<LanguageDropdownButton> createState() => _LanguageDropdownButtonState();
}

class _LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  @override
  void initState() {
    super.initState();

    html.window.onBeforeUnload.listen((html.Event e) {
      setState(() {
        setString(dropdownValue);
      });
    });
    setState(() {
      getString();
    });
  }

  String dropdownValue = "Java";

  Future<void> getString() async {
    final prefs = await SharedPreferences.getInstance();
    dropdownValue = prefs.getString('language') ?? languages.first;
    debugPrint(dropdownValue);
  }

  Future setString(String str) async {
    debugPrint(str);
    final prefs = await SharedPreferences.getInstance();
    dropdownValue = str;
    return prefs.setString('language', str);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        iconSize: 0,
        dropdownColor: const Color.fromARGB(255, 28, 40, 52),
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            context.read<CodeBloc>().add(CodeBlocEventLanguageChange(dropdownValue));
          });
        },
        items: languages.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class FontDropdownButton extends StatefulWidget {
  const FontDropdownButton({super.key});

  @override
  State<FontDropdownButton> createState() => _FontDropdownButtonState();
}

class _FontDropdownButtonState extends State<FontDropdownButton> {
  var dropdownValue = fonts[2];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<double>(
        iconSize: 0,
        dropdownColor: const Color.fromARGB(255, 28, 40, 52),
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (double? value) {
          setState(() {
            dropdownValue = value!;
            context.read<CodeBloc>().add(CodeBlocEventFontChange(dropdownValue));
          });
        },
        items: fonts.map<DropdownMenuItem<double>>((double value) {
          return DropdownMenuItem<double>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
