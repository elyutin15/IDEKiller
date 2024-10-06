import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_state.dart';

List<double?> get fontList {
  final Set<double> top = <double>{10, 12, 14, 16, 18, 20};
  return <double>[
    ...top,
    // null, // Divider
    // ...codeSnippets.keys.where((el) => !top.contains(el))
  ];
}

class FontDropdown extends StatefulWidget {
  const FontDropdown({super.key});

  @override
  State<FontDropdown> createState() => _FontDropdownState();
}

class _FontDropdownState extends State<FontDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeState>(
      builder: (BuildContext context, CodeState state) =>
          DropdownButtonHideUnderline(
        child: DropdownButton<double>(
          iconSize: 0,
          value: state.fontSize,
          elevation: 16,
          style: const TextStyle(color: Colors.white),
          items: fontList.map<DropdownMenuItem<double>>((double? value) {
            return DropdownMenuItem<double>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          icon: Icon(Icons.code, color: Colors.white),
          onChanged: (value) {
            context.read<CodeBloc>().add(CodeFontChangeEvent(value!));
          },
          dropdownColor: const Color.fromARGB(255, 28, 40, 52),
        ),
      ),
    );
  }
}
