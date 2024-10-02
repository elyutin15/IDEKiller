import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';

const List<double> fonts = <double>[10, 12, 14, 16, 18, 20];

class FontDropdown extends StatefulWidget {
  const FontDropdown({super.key});

  @override
  State<FontDropdown> createState() => _FontDropdownState();
}

class _FontDropdownState extends State<FontDropdown> {
  var dropdownValue = fonts[2];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context,CodeBlocState state) => DropdownButtonHideUnderline(
        child: DropdownButton<double>(
          iconSize: 0,
          dropdownColor: const Color.fromARGB(255, 28, 40, 52),
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.white),
          onChanged: (double? value) {
            setState(() {
              dropdownValue = value!;
              context
                  .read<CodeBloc>()
                  .add(CodeBlocEventFontChange(state.code, dropdownValue, state.language, state.response));
            });
          },
          items: fonts.map<DropdownMenuItem<double>>((double value) {
            return DropdownMenuItem<double>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
