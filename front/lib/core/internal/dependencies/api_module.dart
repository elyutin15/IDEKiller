import 'package:idekiller/features/auth/data/api/auth_app_util.dart';
import 'package:idekiller/features/home/data/api/home_app_util.dart';
import 'package:idekiller/features/home/data/api/service/mock_service.dart' as home;
import 'package:idekiller/features/auth/data/api/service/mock_service.dart' as auth;

class ApiModule {
  static final HomeAppUtil _homeApiUtil = HomeAppUtil(home.MockService());
  static final AuthAppUtil _authApiUtil = AuthAppUtil(auth.MockService());

  static HomeAppUtil homeApiUtil() {
    return _homeApiUtil;
  }

  static AuthAppUtil authApiUtil() {
    return _authApiUtil;
  }
}
