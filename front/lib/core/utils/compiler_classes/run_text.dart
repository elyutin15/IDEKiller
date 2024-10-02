import 'package:flutter/material.dart';

class RunText extends StatelessWidget {
  const RunText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Run",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }
}

class Stop extends StatelessWidget {
  const Stop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Stop",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }
}
