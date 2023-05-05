import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
import 'package:idekiller/utils/userPreferences.dart';
import 'package:idekiller/screens/auth/widgets/appbarWidget.dart';
import 'package:idekiller/screens/auth/widgets/buttonWidget.dart';
import 'package:idekiller/screens/auth/widgets/numberWidget.dart';
import 'package:idekiller/screens/auth/widgets/profileWidget.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
  super.initState();


  }

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user!.profilePic,
              onClicked: () {
                Get.rootDelegate.toNamed(Routes.editProfile);
              },
            ),

            const SizedBox(height: 24),
            buildName(),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(),
          ],
        ),
      );
    }


  Widget buildName() => Column(
    children: [
      Text(
        user!.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user!.number,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Show saved files',
    onClicked: () async {
    },
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user!.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}