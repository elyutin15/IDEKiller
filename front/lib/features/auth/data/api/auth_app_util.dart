import 'package:idekiller/features/auth/data/api/request/get_user_body.dart';
import 'package:idekiller/features/auth/data/api/service/service.dart';
import 'package:idekiller/features/auth/data/mapper/user_mapper.dart';
import 'package:idekiller/features/auth/domain/entity/user_entity.dart';

class AuthAppUtil {
  final Service _service;

  AuthAppUtil(this._service);

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final body =
    GetUserBody(email: email, password: password);
    final result = await _service.login(body);
    return UserMapper.fromApi(result);
  }
}
