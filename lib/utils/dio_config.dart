import 'package:dio/dio.dart';
import 'package:teste_projeto_47/main.dart';
import 'package:teste_projeto_47/utils/constants.dart';

Future<Dio> dioInstance() async {
  Dio dio = Dio();

  dio.options.baseUrl = Constants.apiUrl;

  if (sharedPreferences != null) {
    dio.options.headers['Authorization'] =
        'Bearer ${sharedPreferences!.getString('token')}';
  }

  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Content-Type'] = 'application/json';

  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['lang'] = sharedPreferences!.getString('lang') ?? "pt";

  return dio;
}
