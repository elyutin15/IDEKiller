import 'package:flutter/material.dart';
import 'package:idekiller/core/utils/compiler_classes/buttons.dart';
import 'package:idekiller/core/utils/compiler_classes/dropdown_button.dart';
import 'package:idekiller/core/utils/compiler_classes/save_code_button.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 28, 40, 52),
      title: const Text(
        "Online Compiler",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      actions: const [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
