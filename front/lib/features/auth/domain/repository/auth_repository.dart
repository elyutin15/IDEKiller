import 'package:idekiller/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });
}
