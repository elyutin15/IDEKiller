import 'package:idekiller/features/auth/data/api/model/api_user.dart';
import 'package:idekiller/features/auth/data/api/request/get_user_body.dart';

abstract class Service {
  Future<ApiUser> login(GetUserBody body);
}
