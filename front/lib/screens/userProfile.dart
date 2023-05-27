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
import 'package:idekiller/controllers/rrequests.dart';

class Subscriber {
  final String name;
  //final String photoUrl;

  Subscriber({required this.name/*, required this.photoUrl*/});
}

class Subscription {
  final String name;
  //final String photoUrl;

  Subscription({required this.name/*, required this.photoUrl*/});
}

class Code {
  final String title;
  final String value;

  Code({required this.title, required this.value});
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _user;
  late User user;
  final TextEditingController searchTextController = TextEditingController();
  //late User user;
  bool _isLoading = false;
  List<Code> _codesList = [Code(title: '1title', value: '1value'),Code(title: '2title', value: '2value'),Code(title: '3title', value: '3value')];
  List<Subscription> _subscriptionsList = [Subscription(name: 'name1'), Subscription(name: 'name2'),Subscription(name: 'name3'),Subscription(name: 'name4')];
  List<Subscriber> _subscribersList = [Subscriber(name: '1name'), Subscriber(name: '2name'),Subscriber(name: '3name'),Subscriber(name: '4name')];

  @override
  void initState() {
    super.initState();
    _user = getUserData(2 );
    //getUserData(1);
  }

  Future<User> getUserData(int userId) async {
    final response = await http.get(Uri.parse('http://localhost:8081/profile/$userId'));
    if (response.statusCode == 200) {
      //final userData = json.decode(response.body);
      return userFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Мой профиль')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<User>(
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
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Введите id пользователя, которому хотите отправить запрос',
                      hintStyle: TextStyle(color: Colors.white),
                      //border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'Преподаватели'),
                      Tab(text: 'Ученики'),
                      Tab(text: 'Коды'),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        MyApiClient.addFriend(user.id, int.parse(searchTextController.text));
                        searchTextController.clear();
                        final query = searchTextController.text;
                        // Обработка запроса поиска
                      },
                    ),
                  ],
                ),
                /*appBar: AppBar(
                  title: Text('Мои списки'),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'Преподаватели'),
                      Tab(text: 'Ученики'),
                      Tab(text: 'Коды'),
                    ],
                  ),
                ),*/
                body: TabBarView(
                  children: [
                    _isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        //final subscriber = _subscribersList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                          ),
                          title: Text('maks'),
                          subtitle: Text('123@123.3'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Переходя к профилю друга
                          },
                          //leading: Image.network(/*subscriber.photoUrl*/'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                          //title: Text(subscriber.name),
                        );
                      },
                      //itemCount: _subscribersList.length,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                      itemBuilder: (context, index) {
                        final subscription = _subscriptionsList[index];
                        return ListTile(
                          leading: Image.network(/*subscription.photoUrl*/'https://picsum.photos/250?image=9'),
                          title: Text(subscription.name),
                        );
                      },
                      itemCount: _subscriptionsList.length,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                      itemBuilder: (context, index) {
                        final code = _codesList[index];
                        return ListTile(
                          title: Text(code.title),
                          subtitle: Text(code.value),
                        );
                      },
                      itemCount: _codesList.length,
                    ),
                  ],
                ),
              ),

            ),
          ),
          )],
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<User>(
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
*/

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
    text: 'Edit profile',
    onClicked: () async {
      Get.rootDelegate.toNamed(Routes.editProfile);
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