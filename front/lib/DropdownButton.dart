import 'package:flutter/material.dart';
import 'package:idekiller/GlobalValues.dart';

const List<String> list = <String>['C++', 'C', 'Java', 'Python'];

// ignore: must_be_immutable
class LanguageDropdownButton extends StatelessWidget {
  String dropdownValue = list.first;

  LanguageDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          GlobalValues.language = value!;
          dropdownValue = value;
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
