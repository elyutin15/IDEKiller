import 'package:flutter/material.dart';
import 'package:idekiller/utils/GlobalValues.dart';

const List<String> languages = <String>['Java', 'C++', 'C', 'Python'];
const List<double> fonts = <double>[10, 12, 14, 16, 18, 20];

class LanguageDropdownButton extends StatefulWidget {
  final VoidCallback update;
  const LanguageDropdownButton({Key? key,required this.update}): super(key: key);

  @override
  State<LanguageDropdownButton> createState() => _LanguageDropdownButtonState();
}

class _LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  String dropdownValue = languages.first;

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
            switch(GlobalValues.language){
              case "C++":
                GlobalValues.code =
                    "#include <iostream>\n"
                    "\n"
                    "using namespace std;\n"
                    "int main(void) {\n"
                    "  cout << \"Hello world\" <<end;\n"
                    "}\n";
                break;
              case "Java":
                GlobalValues.code ="public class Main {\n  public static void main (String[] args) {\n    System.out.println(\"Hello, World\");\n  }\n}";
                break;
              case "C":
                GlobalValues.code =
                    "#include <stdio.h>\n"
                    "\n"
                    "int main(void) {\n"
                    "  printf(\"Hello world\");\n"
                    "}\n";
                break;
              case "Python":
                GlobalValues.code =
                    "print(\"Hello, World!\")";
              break;
            }
            debugPrint(GlobalValues.language);
            debugPrint(GlobalValues.code);
            dropdownValue = value;
            widget.update();
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
  final VoidCallback update;
  const FontDropdownButton({Key? key, required this.update}) : super(key: key);

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
            widget.update();
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
