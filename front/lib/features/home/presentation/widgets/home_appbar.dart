import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idekiller/core/internal/routes.dart';
import 'package:idekiller/features/home/presentation/widgets/font_dropdown.dart';
import 'package:idekiller/features/home/presentation/widgets/language_dropdown.dart';
import 'package:idekiller/features/home/presentation/widgets/theme_dropdown.dart';

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
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const FontDropdown(),
              const SizedBox(
                width: 12,
              ),
              const LanguageDropdown(),
              const SizedBox(
                width: 12,
              ),
              const ThemeDropdown(),
              const SizedBox(
                width: 12,
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_box_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  saveCodeDialog(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.go("/login");
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

Future<void> saveCodeDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Column(
        children: [
          Text("Please login to save snippet to your personal account"),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
        ],
      ),
      content: const Text(
        "Login with",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: const Text(
                    "Email",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: const Text(
                    "Phone",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
