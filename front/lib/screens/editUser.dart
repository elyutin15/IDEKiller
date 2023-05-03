import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idekiller/controllers/model.dart';
import 'package:idekiller/utils/userPreferences.dart';
import 'auth/widgets/appbarWidget.dart';
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
  TextEditingController aboutController = TextEditingController(text: user!.about);
  TextEditingController nameController = TextEditingController(text: user!.name);
  TextEditingController numberController = TextEditingController(text: user!.number);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user!.profilePic,
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
                      ElevatedButton(onPressed: () async {
                        user!.about = aboutController.text;
                        user!.name = nameController.text;
                        user!.number = numberController.text;

                        var url = 'http://localhost:8081/profile/${user!.id}';

                        await http
                            .patch(Uri.parse(url),
                            headers: {
                              "Content-Type": "application/json",
                            },
                            body: userToJson(user!)/*json.encode({
            "number": 'a',
            "password": 'a'
          })*/)
                            .then((http.Response response) {
                          switch(response.statusCode){
                            case 200:
                              user = userFromJson(response.body);
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
                        /*
                        var url = 'http://localhost:8081/profile/${user!.id}';

                        await http
                            .patch(Uri.parse(url),
                            headers: {
                              "Content-Type": "application/json",
                            },
                            body: user!.toJson())
                            .then((http.Response response) {
                          switch(response.statusCode){
                            case 200:
                              user = userFromJson(response.body);
                              Get.rootDelegate.toNamed(Routes.profile);
                              break;
                            case 500:
                              debugPrint('Проблема с подключением к базе данных');
                              break;
                            default:
                              debugPrint('');
                              break;
                          }
                        });*/
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
              controller: nameController,
              label: 'Full Name',
              text: user!.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: numberController,
              label: 'number',
              text: user!.number,
              onChanged: (number) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: aboutController,
              label: 'About',
              text: user!.about,
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