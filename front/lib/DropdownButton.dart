import 'package:flutter/material.dart';
import 'package:idekiller/GlobalValues.dart';

const List<String> list = <String>['C++', 'C', 'Java', 'Python'];

// ignore: must_be_immutable
class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

  @override
  State<LanguageDropdownButton> createState() => _LanguageDropdownButtonState();
}

class _LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value) {
          setState(() {
            GlobalValues.language = value!;
            dropdownValue = value;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
