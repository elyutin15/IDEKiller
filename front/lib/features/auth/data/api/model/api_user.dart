class ApiUser {
  final String email;
  final String password;

  ApiUser.fromApi(Map<String, dynamic> map)
      : email = map['email'],
        password = map['password'];
}
