import 'package:idekiller/features/home/data/api/model/api_response.dart';
import 'package:idekiller/features/home/domain/entity/response_entity.dart';

class ResponseMapper {
  static ResponseEntity fromApi(ApiResponse response) {
    return ResponseEntity(response: response.response);
  }
}
