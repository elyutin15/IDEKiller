import 'package:idekiller/features/auth/data/api/model/api_user.dart';
import 'package:idekiller/features/auth/data/api/request/get_user_body.dart';
import 'package:idekiller/features/auth/data/api/service/service.dart';

class MockService implements Service {
  @override
  Future<ApiUser> login(GetUserBody body) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = {'email': 'test.email', 'password': 'test.password'};
    return ApiUser.fromApi(response);
  }
}
