import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

const List<String> languages = <String>['Java', 'C++', 'C', 'Python'];

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String dropdownValue = "Java";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context, CodeBlocState state) =>
          DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconSize: 0,
          dropdownColor: const Color.fromARGB(255, 28, 40, 52),
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
              context.read<CodeBloc>().add(CodeBlocEventLanguageChange(
                  state.code, state.fontSize, dropdownValue, state.response));
            });
          },
          items: languages.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
