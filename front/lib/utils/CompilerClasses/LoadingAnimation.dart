import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  late bool load;

  LoadingAnimation({Key? key, required this.load}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return load
        ? SizedBox(
            child: LoadingAnimationWidget.threeArchedCircle(
              size: 30,
              color: const Color(0xFFEA3799),
            ),
          )
        : Container();
  }
}
