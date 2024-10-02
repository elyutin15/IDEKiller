import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idekiller/core/presentation/widgets/compiler_appbar.dart';
import 'package:idekiller/core/utils/compiler_classes/main_scrollable_page.dart';
import 'package:idekiller/features/compiler/presentation/bloc/code_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CodeBloc>(
        create: (BuildContext context) => CodeBloc(),
        child: const Column(
          children: [
            CompilerAppBar(),
            Divider(height: 0, color: Colors.black),
            Expanded(
              child: MainScrollablePage(),
            ),
          ],
        ),
      ),
    );
  }
}
