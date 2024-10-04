import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/utils/code_snippets.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

List<String?> get languageList {
  const top = <String>{
    "java",
    "cpp",
    "python",
  };
  return <String?>[
    ...top,
    null, // Divider
    ...codeSnippets.keys.where((el) => !top.contains(el))
  ];
}

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context, CodeBlocState state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: state.language,
            items: languageList.map((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == null
                    ? Divider()
                    : Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
            icon: Icon(Icons.code, color: Colors.white),
            onChanged: (value) {
              context.read<CodeBloc>().add(CodeBlocEventLanguageChange(value!));
            },
            dropdownColor: const Color.fromARGB(255, 28, 40, 52),
          ),
        );
      },
    );
  }
}
