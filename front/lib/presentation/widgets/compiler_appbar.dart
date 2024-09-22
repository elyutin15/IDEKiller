import 'package:flutter/material.dart';
import 'package:idekiller/utils/compiler_classes/buttons.dart';
import 'package:idekiller/utils/compiler_classes/dropdown_button.dart';
import 'package:idekiller/utils/compiler_classes/save_code_button.dart';
import 'package:idekiller/utils/compiler_classes/tiles.dart';

class CompilerAppBar extends StatelessWidget {
  const CompilerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 28, 40, 52),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CompilerTitle(),
          FontDropdownButton(),
          SizedBox(
            width: 40,
          ),
          LanguageDropdownButton(),
          SizedBox(
            width: 20,
          ),
          SaveCodeButton(),
          RegistrationPage(),
        ],
      ),
    );
  }
}
