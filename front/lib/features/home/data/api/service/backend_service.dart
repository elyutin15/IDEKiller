import 'package:dio/dio.dart';
import 'package:idekiller/features/home/data/api/model/api_response.dart';
import 'package:idekiller/features/home/data/api/request/get_response_body.dart';
import 'package:idekiller/features/home/data/api/service/service.dart';

class BackendService implements Service {
  static const _base_url = 'http://localhost:8080';

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _base_url),
  );

  @override
  Future<ApiResponse> getResponse(GetResponseBody body) async {
    final response = await _dio.post(
      '/json',
      queryParameters: body.toApi(),
    );
    return ApiResponse.fromApi(response.data);
  }
}
