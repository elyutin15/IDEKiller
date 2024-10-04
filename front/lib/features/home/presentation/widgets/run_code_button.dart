import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_event.dart';

class RunCodeButton extends StatefulWidget {
  const RunCodeButton({super.key});

  @override
  State<RunCodeButton> createState() => _RunCodeButtonState();
}

class _RunCodeButtonState extends State<RunCodeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CodeBloc>().add(CodeBlocEventRun());
      },
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Colors.blue.shade400), //tex
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey.withOpacity(0.8);
            }
            return Colors.transparent;
          },
        ),
      ),
      child: const Text(
        "Run",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}
