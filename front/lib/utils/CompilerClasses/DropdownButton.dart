import 'package:flutter/material.dart';
import 'package:idekiller/utils/GlobalValues.dart';

const List<String> languages = <String>['C++', 'C', 'Java', 'Python'];
const List<double> fonts = <double>[10, 12, 14, 16, 18, 20];

class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

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
