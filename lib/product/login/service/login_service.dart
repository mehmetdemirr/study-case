import 'dart:io';

import 'package:demo/core/cache/shared_pref.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ILoginService {
  ILoginService(this.dio);
  final Dio dio;
  Future<bool> login(String mail, String password);
}

class LoginService extends ILoginService {
  LoginService(super.dio);

  @override
  Future<bool> login(String mail, String password) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(
        ApiItem.login.str(),
        data: {
          "email": mail,
          "password": password,
        },
      );
      if (result.statusCode == HttpStatus.ok) {
        var jsonBody = result.data;
        if (jsonBody is Map<String, dynamic>) {
          String token = jsonBody["token"];
          printf("token: $token");
          await SharedPref().setToken(token);
          return true;
        }
      }
    } catch (e) {
      printf("error");
    }
    return false;
  }
}
