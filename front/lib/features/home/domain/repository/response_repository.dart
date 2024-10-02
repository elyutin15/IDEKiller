import 'package:idekiller/features/home/domain/entity/response_entity.dart';

abstract class ResponseRepository {
  Future<ResponseEntity> getResponse({
    required String code,
    required String language,
    required String words,
  });
}
