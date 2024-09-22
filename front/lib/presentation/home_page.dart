import 'package:flutter/material.dart';
import 'package:idekiller/presentation/widgets/compiler_appbar.dart';
import 'package:idekiller/utils/compiler_classes/main_scrollable_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CompilerAppBar(),
          ),
          Divider(height: 0, color: Colors.black),
          Expanded(
            flex: 10,
            child: MainScrollablePage(),
          ),
        ],
      ),
    );
  }
}
