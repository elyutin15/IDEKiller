import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 5),
      child: RichText(
        text: const TextSpan(
            text: "Input Console",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}

class OutputTitle extends StatelessWidget {
  const OutputTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 5),
      child: RichText(
        text: const TextSpan(
            text: "Output Console",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}

class CompilerTitle extends StatelessWidget {
  const CompilerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(
          "Online Compiler",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
