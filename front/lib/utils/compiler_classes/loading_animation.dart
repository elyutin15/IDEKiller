import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatefulWidget {
  final bool load;

  const LoadingAnimation({super.key, required this.load});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return widget.load
        ? SizedBox(
      child: LoadingAnimationWidget.staggeredDotsWave(
        size: 30,
        color: const Color(0xFF37EAC9),
      ),
    )
        : Container();
  }
}