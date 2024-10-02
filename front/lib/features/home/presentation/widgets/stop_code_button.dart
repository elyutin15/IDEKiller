import 'package:flutter/material.dart';

class StopCodeButton extends StatelessWidget {
  const StopCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            Colors.pink.shade400), //text (and icon)
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey.withOpacity(0.8);
            }
            return Colors.transparent;
          },
        ),
      ),
      child: const Text(
        "Stop",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}
