import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/api/api_client.dart';
import 'package:get/get.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserList() async {
    // Pass only the endpoint, the base url is passed at initialization
    return await apiClient.getData(kUserUri);
  }
}
