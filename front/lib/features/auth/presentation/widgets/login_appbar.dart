import 'package:flutter/material.dart';

class LoginAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppbar({super.key});

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
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
