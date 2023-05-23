/*
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PhotoPickerScreen extends StatefulWidget {
  @override
  _PhotoPickerScreenState createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  Uint8List? _imageBytes;

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите фотографию'),
      ),
      body: GestureDetector(
        onTap: _pickImage,
        child: Center(
          child: _imageBytes != null
              ? Image.memory(_imageBytes!)
              : Icon(Icons.add_a_photo, size: 64),
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Subscriber {
  final String name;
  final String photoUrl;
  final String bio;

  Subscriber({required this.name, required this.photoUrl, required this.bio});
}

class SubscribersListScreen extends StatelessWidget {
  final List<Subscriber> subscribersList = [
    Subscriber(name: 'John Doe', photoUrl: 'assets/images/john_doe.svg', bio: 'Web Developer'),
    Subscriber(name: 'Jane Smith', photoUrl: 'assets/images/jane_smith.svg', bio: 'Graphic Designer'),
    Subscriber(name: 'Mark Johnson', photoUrl: 'assets/images/mark_johnson.svg', bio: 'Mobile Developer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список подписчиков'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final subscriber = subscribersList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(subscriber: subscriber)));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    subscriber.photoUrl,
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subscriber.name, style: TextStyle(fontSize: 20)),
                      SizedBox(height: 8),
                      Text(subscriber.bio),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: subscribersList.length,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Subscriber subscriber;

  ProfileScreen({required this.subscriber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subscriber.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              subscriber.photoUrl,
              height: 128,
              width: 128,
            ),
            SizedBox(height: 16),
            Text(subscriber.name, style: TextStyle(fontSize: 32)),
            SizedBox(height: 16),
            Text(subscriber.bio, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}








import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Subscriber {
  final String name;
  final String photoUrl;

  Subscriber({required this.name, required this.photoUrl});
}

class Subscription {
  final String name;
  final String photoUrl;

  Subscription({required this.name, required this.photoUrl});
}

class Code {
  final String title;
  final String value;

  Code({required this.title, required this.value});
}

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool _isLoading = false;
  List<Subscriber> _subscribersList = [];
  List<Subscription> _subscriptionsList = [];
  List<Code> _codesList = [];

  Future<List<Subscriber>> _fetchSubscribers() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse('https://example.com/subscribers'));
    setState(() {
      _isLoading = false;
      final List<dynamic> subscribersJsonList = json.decode(response.body)['subscribers'];
      _subscribersList = subscribersJsonList.map((subscriberJson) => Subscriber(
        name: subscriberJson['name'],
        photoUrl: subscriberJson['photo_url'],
      )).toList();
    });
    return _subscribersList;
  }

  Future<List<Subscription>> _fetchSubscriptions() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse('https://example.com/subscriptions'));
    setState(() {
      _isLoading = false;
      final List<dynamic> subscriptionsJsonList = json.decode(response.body)['subscriptions'];
      _subscriptionsList = subscriptionsJsonList.map((subscriptionJson) => Subscription(
        name: subscriptionJson['name'],
        photoUrl: subscriptionJson['photo_url'],
      )).toList();
    });
    return _subscriptionsList;
  }

  Future<List<Code>> _fetchCodes() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse('https://example.com/codes'));
    setState(() {
      _isLoading = false;
      final List<dynamic> codesJsonList = json.decode(response.body)['codes'];
      _codesList = codesJsonList.map((codeJson) => Code(
        title: codeJson['title'],
        value: codeJson['value'],
      )).toList();
    });
    return _codesList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мои данные'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Подписчики'),
              Tab(text: 'Подписки'),
              Tab(text: 'Коды'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
              itemBuilder: (context, index) {
                final subscriber = _subscribersList[index];
                return ListTile(
                  leading: Image.network(subscriber.photoUrl),
                  title: Text(subscriber.name),
                );
              },
              itemCount: _subscribersList.length,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
              itemBuilder: (context, index) {
                final subscription = _subscriptionsList[index];
                return ListTile(
                  leading: Image.network(subscription.photoUrl),
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
    );
  }
}














import 'dart:convert';
import 'dart:html';

class UserData {
  final String name;
  final int age;

  UserData({required this.name, required this.age});

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}

void saveUserData(UserData userData) {
  final storage = window.localStorage;
  storage['user_data'] = json.encode(userData.toJson());
}

UserData? getUserData() {
  final storage = window.localStorage;
  final userDataJson = storage['user_data'];
  if (userDataJson != null) {
    final userDataMap = json.decode(userDataJson);
    return UserData(name: userDataMap['name'], age: userDataMap['age']);
  }
  return null;
}
*/



/*
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


  List<String> _subscriptions = ['Netflix', 'Spotify', 'Adobe Creative Cloud'];


  List<String> _savedItems = ['Избранные фильмы', 'Избранные сериалы', 'Избранные песни'];


  List<String> _followers = ['John Doe', 'Jane Doe', 'Joe Bloggs'];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Личный кабинет')),
      body: _selectedIndex == 0 ?
      ListView.builder(
          itemCount: _subscriptions.length,
          itemBuilder: (context, index) => ListTile(title: Text(_subscriptions[index]))
      )
          : _selectedIndex == 1 ?
      ListView.builder(
          itemCount: _savedItems.length,
          itemBuilder: (context, index) => ListTile(title: Text(_savedItems[index]))
      )
          : ListView.builder(
          itemCount: _followers.length,
          itemBuilder: (context, index) => ListTile(title: Text(_followers[index]))
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: 'Подписки'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Подписчики'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}



import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  List<String> _shopItems = ['Молоко', 'Хлеб', 'Яблоки', 'Мясо', 'Яйца', 'Сок', 'Сыр', 'Специи'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список покупок')),
      body: ListView.builder(
          itemCount: _shopItems.length,
          itemBuilder: (context, index){
            return ListTile(title: Text(_shopItems[index]),);
          }
      ),
    );
  }
}

onPressed: () {
setState(() {
_shopItems.add("New Item");
});
}


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyFriend {
String name;

MyFriend({this.name});

factory MyFriend.fromJson(Map<String, dynamic> json) {
return MyFriend(
name:json['name'],
);
}
}

class FriendList extends StatefulWidget {
@override
_FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {

List<MyFriend> _friends = List<MyFriend>();

Future<List<MyFriend>> fetchFriends() async{
  var url = 'https://your.api.endpoint.com/friends';
  var response = await http.get(url);

  var friends = List<MyFriend>();

  if(response.statusCode == 200){
  var friendsJson = json.decode(response.body);
  for(var friendJson in friendsJson){
  friends.add(MyFriend.fromJson(friendJson));
  }
  }
  return friends;
}

@override
void initState(){
fetchFriends().then((value){
setState(() {
_friends.addAll(value);
});
});
super.initState();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Список друзей')),
body: ListView.builder(
itemCount: _friends.length,
itemBuilder: (context, index){
return ListTile(title: Text(_friends[index].name),);
}),
);
}
}*/
