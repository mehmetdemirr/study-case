import 'dart:io';

import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/home_screen/model/data_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IUserService {
  IUserService(this.dio);
  final Dio dio;
  Future<UserData?> getUsers(int page);
}

class UserService extends IUserService {
  UserService(super.dio);

  @override
  Future<UserData?> getUsers(int page) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.get(
        "${ApiItem.users.str()}=$page",
      );
      if (result.statusCode == HttpStatus.ok) {
        var jsonBody = result.data;
        if (jsonBody is Map<String, dynamic>) {
          UserData? userData = UserData.fromJson(jsonBody);
          return userData;
        }
      }
    } catch (e) {
      printf("error");
    }
    return null;
  }
}
