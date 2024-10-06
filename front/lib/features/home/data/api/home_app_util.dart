import 'package:idekiller/features/home/data/api/request/get_response_body.dart';
import 'package:idekiller/features/home/data/api/service/service.dart';
import 'package:idekiller/features/home/data/mapper/response_mapper.dart';
import 'package:idekiller/features/home/domain/entity/response_entity.dart';

class HomeAppUtil {
  final Service _service;

  HomeAppUtil(this._service);

  Future<ResponseEntity> getResponse({
    required String code,
    required String language,
    required String words,
  }) async {
    final body =
        GetResponseBody(code: Code(code, language), input: Input(words));
    final result = await _service.getResponse(body);
    return ResponseMapper.fromApi(result);
  }
}
