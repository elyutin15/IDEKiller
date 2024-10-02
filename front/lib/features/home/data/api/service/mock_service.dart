import 'package:idekiller/features/home/data/api/model/api_response.dart';
import 'package:idekiller/features/home/data/api/request/get_response_body.dart';
import 'package:idekiller/features/home/data/api/service/service.dart';

class MockService implements Service {
  @override
  Future<ApiResponse> getResponse(GetResponseBody body) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = {'response': 'hello world'};
    return ApiResponse.fromApi(response);
  }
}
