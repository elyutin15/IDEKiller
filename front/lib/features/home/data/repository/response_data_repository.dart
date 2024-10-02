import 'package:idekiller/features/home/data/api/app_util.dart';
import 'package:idekiller/features/home/domain/entity/response_entity.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';

class ResponseDataRepository extends ResponseRepository {
  final ApiUtil _apiUtil;

  ResponseDataRepository(this._apiUtil);

  @override
  Future<ResponseEntity> getResponse({ required String code, required String language, required String words}) {

    return _apiUtil.getResponse(code: code, language: language, words: words);

  }
}