import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/api/api_client.dart';
import 'package:ceiba_book/src/data/repositories/user_repository.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // Initialize our ApiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: kBaseUrl));

  // Initialize the repositories, use the get.find to get the apiClient instance
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  // Initialize the controllers, use the get.find to get the Controllers instance
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}
