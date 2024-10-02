import 'package:flutter/material.dart';
import 'package:idekiller/features/home/presentation/widgets/body.dart';
import 'package:idekiller/features/home/presentation/widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppbar(),
      body: Body(),
    );
  }
}
