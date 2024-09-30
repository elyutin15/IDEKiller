import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/Buttons.dart';
import 'package:idekiller/utils/CompilerClasses/DropdownButton.dart';
import 'package:idekiller/utils/CompilerClasses/SaveCodeButton.dart';
import 'package:idekiller/utils/CompilerClasses/Titles.dart';

class CompilerAppBar extends StatelessWidget {
  final VoidCallback update;

  const CompilerAppBar({Key? key, required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 28, 40, 52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CompilerTitle(),
          FontDropdownButton(
            update: update,
          ),
          const SizedBox(
            width: 40,
          ),
          LanguageDropdownButton(
            update: update,
          ),
          const SizedBox(
            width: 20,
          ),
          const SaveCodeButton(),
          const RegistrationPage(),
        ],
      ),
    );
  }
}
