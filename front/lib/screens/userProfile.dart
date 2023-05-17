import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
import 'package:idekiller/utils/GlobalValues.dart';
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
  //late Future<User> _user;
  late User user;

  @override
  void initState() {
  super.initState();
    //_user = getUserData(1);
    getUserData(1);
  }

  Future<void> getUserData(int userId) async {
    final response = await http.get(Uri.parse('http://localhost:8081/profile/$userId'));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      user = userFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: GlobalValues.user.profilePic,
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
        GlobalValues.user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        GlobalValues.user.number,
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
          GlobalValues.user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}