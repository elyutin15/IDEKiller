import 'package:idekiller/features/auth/data/api/auth_app_util.dart';
import 'package:idekiller/features/auth/domain/entity/user_entity.dart';
import 'package:idekiller/features/auth/domain/repository/auth_repository.dart';

class AuthDataRepository extends AuthRepository {
  final AuthAppUtil _apiUtil;

  AuthDataRepository(this._apiUtil);


  @override
  Future<UserEntity> login({required String email, required String password}) {
    return _apiUtil.login(email: email, password: password);
  }
}