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
