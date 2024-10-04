import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';
import 'package:idekiller/features/home/presentation/widgets/themes.dart';

List<String?> get themeList {
  const top = <String>{
    "monokai-sublime",
    "a11y-dark",
    "an-old-hope",
    "vs2015",
    "vs",
    "atom-one-dark",
  };
  return <String?>[
    ...top,
    null, // Divider
    ...themes.keys.where((el) => !top.contains(el))
  ];
}

class ThemeDropdown extends StatefulWidget {
  const ThemeDropdown({super.key});

  @override
  State<ThemeDropdown> createState() => _ThemeDropdownState();
}

class _ThemeDropdownState extends State<ThemeDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context, CodeBlocState state) =>
          DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.theme,
          items: themeList.map((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: value == null
                  ? Divider()
                  : Text(value, style: TextStyle(color: Colors.white)),
            );
          }).toList(),
          icon: Icon(Icons.color_lens, color: Colors.white),
          onChanged: (value) {
            context.read<CodeBloc>().add(CodeBlocEventThemeChange(value!));
          },
          dropdownColor: const Color.fromARGB(255, 28, 40, 52),
        ),
      ),
    );
  }
}
