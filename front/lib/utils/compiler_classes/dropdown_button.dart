import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:idekiller/utils/global_values.dart';
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
        dropdownValue = GlobalValues.language;
      });
    });
    setState(() {
      getString();
      dropdownValue = GlobalValues.language;
    });
  }

  String dropdownValue = GlobalValues.language;

  Future<void> getString() async {
    final prefs = await SharedPreferences.getInstance();
    dropdownValue = prefs.getString('language') ?? languages.first;
    GlobalValues.language = dropdownValue;
    debugPrint(dropdownValue);
  }

  Future setString(String str) async {
    debugPrint(str);
    final prefs = await SharedPreferences.getInstance();
    GlobalValues.language = str;
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
            GlobalValues.language = value!;
            setString(value);
            switch (GlobalValues.language) {
              case "C++":
                GlobalValues.code = "#include <iostream>\n"
                    "\n"
                    "using namespace std;\n"
                    "int main(void) {\n"
                    "  cout << \"Hello world\" <<endl;\n"
                    "}\n";
                break;
              case "Java":
                GlobalValues.code =
                    "public class Main {\n  public static void main (String[] args) {\n    System.out.println(\"Hello, World\");\n  }\n}";
                break;
              case "C":
                GlobalValues.code = "#include <stdio.h>\n"
                    "\n"
                    "int main(void) {\n"
                    "  printf(\"Hello world\");\n"
                    "}\n";
                break;
              case "Python":
                GlobalValues.code = "print(\"Hello, World!\")";
                break;
            }
            debugPrint(GlobalValues.language);
            debugPrint(GlobalValues.code);
            dropdownValue = value;
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
            GlobalValues.font = value!;
            debugPrint(GlobalValues.font.toString());
            dropdownValue = value;
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
