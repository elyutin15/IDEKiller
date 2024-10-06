import 'package:idekiller/core/internal/dependencies/api_module.dart';
import 'package:idekiller/features/auth/data/repository/auth_data_repository.dart';
import 'package:idekiller/features/auth/domain/repository/auth_repository.dart';
import 'package:idekiller/features/home/data/repository/response_data_repository.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';

class RepositoryModule {
  static final ResponseRepository _responseRepository = ResponseDataRepository(ApiModule.homeApiUtil());
  static final AuthRepository _authRepository = AuthDataRepository(ApiModule.authApiUtil());

  static ResponseRepository responseRepository() {
    return _responseRepository;
  }

  static AuthRepository authRepository() {
    return _authRepository;
  }
}