class ApiEndPoints {
  static const String baseUrl = 'http://restapi.adequateshop.com/api/';
  static AuthEndPoints authEndpoints = AuthEndPoints();
}

class AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}

class Routes {
  static String homeRoute = '/';
  static String authentication = '/authentication';
  static String profile = '/profile';
  static String editProfile = '/profile/edit';
}