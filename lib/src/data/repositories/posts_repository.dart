import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/api/api_client.dart';
import 'package:get/get.dart';

class PostRepo extends GetxService {
  final ApiClient apiClient;

  PostRepo({required this.apiClient});

  Future<Response> getPostsList() async {
    // Pass only the endpoint, the base url is passed at initialization
    return await apiClient.getData(kPostsUri);
  }

  Future<Response> getPostsListByUser(int userId) async {
    // Pass only the endpoint, the base url is passed at initialization
    return await apiClient.getData(kGetUserPosts(userId));
  }
}
