import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeBloc, CodeBlocState>(
      builder: (BuildContext context, state) {
        return (state is CodeBlocStateLoading)
            ? SizedBox(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 30,
                  color: const Color(0xFF37EAC9),
                ),
              )
            : Container();
      },
    );
  }
}
