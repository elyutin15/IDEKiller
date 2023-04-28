class ApiEndPoints {
  static const String baseUrl = 'http://localhost:8081';
  static AuthEndPoints authEndpoints = AuthEndPoints();
}

class AuthEndPoints {
  final String registerEmail = '/register';
  final String loginEmail = '/login';
}

class Routes {
  static String homeRoute = '/';
  static String authentication = '/authentication';
  static String profile = '/profile';
  static String editProfile = '/profile/edit';
}