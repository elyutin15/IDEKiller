import 'package:flutter/material.dart';
import 'package:idekiller/utils/CompilerClasses/CompilerAppBar.dart';
import 'package:idekiller/utils/CompilerClasses/MainScrollablePage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CompilerAppBar(update: _update),
          ),
          const Divider(height: 0, color: Colors.black),
          Expanded(
            flex: 10,
            child: MainScrollablePage(),
          ),
        ],
      ),
    );
  }
}
