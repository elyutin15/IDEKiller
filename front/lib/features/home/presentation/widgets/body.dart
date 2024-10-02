import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/features/home/presentation/bloc/code_bloc.dart';
import 'package:idekiller/features/home/presentation/widgets/main_scrollable_page.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CodeBloc>(
      create: (BuildContext context) => CodeBloc(),
      child: const Column(
        children: [
          Divider(height: 0, color: Colors.black),
          Expanded(
            child: MainScrollablePage(),
          ),
        ],
      ),
    );
  }
}