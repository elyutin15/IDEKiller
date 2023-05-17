import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
//import 'package:idekiller/utils/GlobalValues.dart';
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
  late Future<User> _user;
  late User user;
  //late User user;

  @override
  void initState() {
  super.initState();
    _user = getUserData(2 );
    //getUserData(1);
  }

  Future<User> getUserData(int userId) async {
    final response = await http.get(Uri.parse('http://localhost:8081/profile/$userId'));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      return userFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: buildAppBar(context),
        body:
        FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                user = snapshot.data!;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                      imagePath: user.profilePic,
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
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );

    }


  Widget buildName() => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.number,
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
          user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}

