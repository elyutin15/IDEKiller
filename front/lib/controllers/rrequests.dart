import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idekiller/controllers/model.dart';

class MyApiClient {
  static Future<User> getUserData(String userId) async {
    final response = await http.get(Uri.parse('http://localhost:8081/profile/$userId'));
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<List<FriendRequest>> getFriendRequests(int id) async {
    var response = await http.get(Uri.parse('http://localhost:8081/subscriber/${id}'));
    if(response.statusCode == 200){
      List<dynamic> friendsJson = json.decode(response.body);
      return friendsJson.map((friendJson) => FriendRequest.fromJson(friendJson)).toList();
    }else{
      throw Exception('Failed to load friend requests');
    }
  }
}