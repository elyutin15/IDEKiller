import 'package:idekiller/core/internal/dependencies/api_module.dart';
import 'package:idekiller/features/home/data/repository/response_data_repository.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';

class RepositoryModule {
  static final ResponseRepository _responseRepository = ResponseDataRepository(ApiModule.apiUtil());

  static ResponseRepository responseRepository() {
    return _responseRepository;
  }
}