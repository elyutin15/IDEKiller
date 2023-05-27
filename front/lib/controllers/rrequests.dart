import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idekiller/controllers/model.dart';

class MyApiClient {
  static Future<User> getUserData(int id) async {
    final response = await http.get(Uri.parse('http://localhost:8081/profile/$id'));
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<List<FriendRequest>> getFriendRequests(int id) async {
    var response = await http.get(Uri.parse('http://localhost:8081/subscriber/$id'));
    if(response.statusCode == 200){
      List<dynamic> friendsJson = json.decode(response.body);
      return friendsJson.map((friendJson) => FriendRequest.fromJson(friendJson)).toList();
    }else{
      throw Exception('Failed to load friend requests');
    }
  }

  static Future<int> addFriend(int idFrom, int idTo) async {
    final response = await http.post(Uri.parse('http://localhost:8081/subscriber/add'), body: json.encode({
      "idFrom": idFrom,
      "idTo": idTo
    }), headers: {'Content-Type': 'application/json'});
    return response.statusCode;
  }

  static Future<int> acceptFriend(int idFrom, int idTo) async {
    final response = await http.post(Uri.parse('http://localhost:8081/subscriber/accept'), body: json.encode({
      "idFrom": idFrom,
      "idTo": idTo
    }), headers: {'Content-Type': 'application/json'});
    return response.statusCode;
  }
}