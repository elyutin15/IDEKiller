import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
import 'auth/widgets/appbarWidget.dart';
import 'package:idekiller/utils/GlobalValues.dart';
import 'auth/widgets/profileWidget.dart';
import 'auth/widgets/textFieldWIdget.dart';
import 'package:http/http.dart' as http;
import 'package:idekiller/utils/routes.dart';
import 'package:idekiller/screens/auth/widgets/input_fields.dart';
import 'package:idekiller/screens/auth/widgets/buttonWidget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController aboutController = TextEditingController(text: GlobalValues.user.about);
  TextEditingController nameController = TextEditingController(text: GlobalValues.user.name);
  TextEditingController numberController = TextEditingController(text: GlobalValues.user.number);
  String _imageUrl = '';
  late File file;

  Future<void> _getImage() async {
    final input = FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    await input.onChange.first;
    //final file = input.files!.first;
    file = input.files!.first;
    final reader = FileReader();

    reader.readAsDataUrl(file);

    await reader.onLoad.first;
    final encoded = reader.result as String;

    setState(() {
      _imageUrl = encoded;
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        //appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: _imageUrl.isNotEmpty
                    ? Image.memory(
                  _decodeBase64(_imageUrl.split(',').last),
                  fit: BoxFit.cover,
                ).image
                    : AssetImage('assets/images/profile_default.png'),
              ),
            ),
            /*ProfileWidget(
              imagePath: GlobalValues.user.profilePic,
              isEdit: true,
              onClicked: ()  {

                //Get.rootDelegate.toNamed(Routes.profile);
                },
            ),*/
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: nameController,
              label: 'Full Name',
              text: GlobalValues.user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: numberController,
              label: 'number',
              text: GlobalValues.user.number,
              onChanged: (number) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: aboutController,
              label: 'About',
              text: GlobalValues.user.about,
              maxLines: 5,
              onChanged: (about) {},
            ),
            const SizedBox(height: 20),
            Center(child: ButtonWidget(text: "save", onClicked: (){
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
                    ElevatedButton(onPressed: () async {
                      GlobalValues.user.about = aboutController.text;
                      GlobalValues.user.name = nameController.text;
                      GlobalValues.user.number = numberController.text;

                      var url = 'http://localhost:8081/profile/2';

                      await http
                          .patch(Uri.parse(url),
                          headers: {
                            "Content-Type": "application/json",
                          },
                          body: userToJson(GlobalValues.user)/*json.encode({
            "number": 'a',
            "password": 'a'
          })*/)
                          .then((http.Response response) {
                        switch(response.statusCode){
                          case 200:
                          //GlobalValues.user = userFromJson(response.body);
                            Get.rootDelegate.toNamed(Routes.profile);
                            break;
                          case 500:
                            debugPrint('Проблема с подключением к базе данных');
                            break;
                          default:
                            debugPrint('');
                            break;
                        }
                      });
                      Get.rootDelegate.toNamed(Routes.profile);
                    }, child: Text("Yes")),
                  ],
                  content: Text("Вы хотите сохранить изменения?"),
                );
              });
            }))
          ],
        ),
  );

  Uint8List _decodeBase64(String input) {
    final bytes = base64.decode(input);
    return bytes;
  }
}