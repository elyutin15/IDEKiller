import 'package:get_it/get_it.dart';
import 'package:idekiller/core/internal/dependencies/repository_module.dart';
import 'package:idekiller/features/home/domain/repository/response_repository.dart';

Future<void> setUp() async {
  GetIt.I.registerSingleton<ResponseRepository>(RepositoryModule.responseRepository());
}
