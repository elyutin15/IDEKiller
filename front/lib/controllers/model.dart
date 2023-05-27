// class User {
//   final String imagePath;
//   final String name;
//   final String email;
//   final String about;
//   final bool isDarkMode;
//
//   const User({
//     required this.imagePath,
//     required this.name,
//     required this.email,
//     required this.about,
//     required this.isDarkMode,
//   });
// }
import 'dart:convert';

import 'package:idekiller/utils/CompilerClasses/DropdownButton.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String profilePic;
  String name;
  String number;
  List<UserID> students;
  List<UserID> teachers;
  int id;
  String about;

  User({
    required this.profilePic,
    required this.name,
    required this.number,
    required this.students,
    required this.teachers,
    required this.id,
    required this.about,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    profilePic: json["profilePic"] ?? '',
    name: json["name"] ?? '',
    number: json["number"] ?? '',
    students: List<UserID>.from(json["students"].map((x) => UserID.fromJson(x))),
    teachers: List<UserID>.from(json["teachers"].map((x) => UserID.fromJson(x))),
    id: json["id"],
    about: json["about"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic,
    "name": name,
    "number": number,
    "students": students,//List<dynamic>.from(students.map((x) => x.toJson()))
    "teachers": teachers,//List<dynamic>.from(teachers.map((x) => x.toJson())),
    //"password": "s",
    "id": id,
    "about": about,
  };
}

class UserID {
  int id;
  String name;

  UserID({
    required this.id,
    required this.name,
  });

  factory UserID.fromJson(Map<String, dynamic> json) => UserID(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class FriendRequest{
  int idFrom;
  int idTo;

  FriendRequest({
    required this.idFrom,
    required this.idTo,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
      idFrom: json['idFrom'],
      idTo: json['idTo'],
  );
}

class CodeStruct{
  int id;
  String name;
  Code code;

  CodeStruct({
    required this.id,
    required this.name,
    required this.code,
});
  factory CodeStruct.fromJson(Map<String, dynamic> json) => CodeStruct(
    code: json['code'],
    id: json['id'],
    name: json['name'],
  );
}
class Code {
  String code;
  String language;

  Code({
    required this.code,
    required this.language,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
    code: json["code"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'language': language,
  };
}