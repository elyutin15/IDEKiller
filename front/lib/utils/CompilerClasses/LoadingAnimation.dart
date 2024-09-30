import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final bool load;

  const LoadingAnimation({Key? key, required this.load}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return load
        ? SizedBox(
            child: LoadingAnimationWidget.staggeredDotsWave(
              size: 30,
              color: const Color(0xFF37EAC9),
            ),
          )
        : Container();
  }
}
