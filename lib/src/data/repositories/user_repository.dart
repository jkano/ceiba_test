import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/api/api_client.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<void> clearUsersSavedList() async {
    final box = await Hive.openBox<User>(kUserBox);
    await box.clear();
  }

  Future<List<User>> getUserList() async {
    List<User> userList = [];
    final box = await Hive.openBox<User>(kUserBox);

    // Get the users from the Hive box (if any)
    // await box.clear();
    userList = box.values.toList();

    if (userList.isEmpty) {
      // We dont have any user stored internally, get them from the server
      Response response = await apiClient.getData(kUserUri);

      // Success
      if (response.statusCode == 200) {
        response.body
            .map((jsonUser) => userList.add(User.fromJson(jsonUser)))
            .toList();

        // Add users to Hive box
        box.addAll(userList);
      } else {
        Get.snackbar("Error", "No se pudo obtener los usuarios del servidor",
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ),
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.appCardColor);
      }
    }

    return userList;
  }
}
