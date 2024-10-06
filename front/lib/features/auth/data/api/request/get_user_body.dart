class GetUserBody {
  final String email;
  final String password;

  GetUserBody({required this.email, required this.password});

  Map<String, dynamic> toApi() {
    return {
      'email': email,
      'password': password,
    };
  }
}
