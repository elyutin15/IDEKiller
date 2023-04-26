import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
import 'package:idekiller/utils/userPreferences.dart';
import 'auth/widgets/appbarWidget.dart';
import 'auth/widgets/profileWidget.dart';
import 'auth/widgets/textFieldWIdget.dart';
import 'package:idekiller/utils/routes.dart';
import 'package:idekiller/screens/auth/widgets/buttonWidget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: ()  {
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text("Success"),
                    titleTextStyle:
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,fontSize: 20),
                    actionsOverflowButtonSpacing: 20,
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text("No")),
                      ElevatedButton(onPressed: (){
                        Get.rootDelegate.toNamed(Routes.profile);
                      }, child: Text("Yes")),
                    ],
                    content: Text("Вы хотите сохранить изменения?"),
                  );
                });
                //Get.rootDelegate.toNamed(Routes.profile);
                },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'About',
              text: user.about,
              maxLines: 5,
              onChanged: (about) {},
            ),
            const SizedBox(height: 20),
            // Center(child: ButtonWidget(text: "save", onClicked: (){
            //   AlertDialog(
            //     title: Text("Success"),
            //     titleTextStyle: TextStyle(
            //         fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
            //     actions: [
            //       ElevatedButton(onPressed: (){
            //         Navigator.of(context).pop();
            //       }, child: Text("Close")),
            //     ],
            //     content: Text("Saved successfully"),
            //   );
            // }))
          ],
        ),
  );
}