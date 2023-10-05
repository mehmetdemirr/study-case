import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/home_screen/model/data_model.dart';
import 'package:demo/product/home_screen/service/users_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<User> userList = [];
  int totalPage = 0;
  bool isFirstLoading = false;
  bool isNextLoading = false;

  void changeFirstLoading() {
    isFirstLoading = !isFirstLoading;
    notifyListeners();
  }

  void changeNextLoading() {
    isNextLoading = !isNextLoading;
    notifyListeners();
  }

  Future<void> firstGetUsers() async {
    changeFirstLoading();
    UserData? userData = await UserService(DioManager.dio).getUsers(1);
    userList = userData?.data ?? [];
    totalPage = userData?.totalPages ?? 0;
    changeFirstLoading();
    notifyListeners();
  }

  Future<void> loadGetUsers(int page) async {
    changeNextLoading();
    UserData? userData = await UserService(DioManager.dio).getUsers(page);
    userList += userData?.data ?? [];
    changeNextLoading();
    notifyListeners();
  }
}
