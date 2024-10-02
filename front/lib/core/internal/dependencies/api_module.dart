import 'package:idekiller/features/home/data/api/app_util.dart';
import 'package:idekiller/features/home/data/api/service/mock_service.dart';

class ApiModule {
  static final ApiUtil _apiUtil = ApiUtil(MockService());

  static ApiUtil apiUtil() {
    return _apiUtil;
  }
}
