import 'package:idekiller/features/home/data/api/model/api_response.dart';
import 'package:idekiller/features/home/data/api/request/get_response_body.dart';

abstract class Service {
  Future<ApiResponse> getResponse(GetResponseBody body);
}
