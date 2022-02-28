import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/api/api_client.dart';
import 'package:ceiba_book/src/domain/models/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostRepo extends GetxService {
  final ApiClient apiClient;

  PostRepo({required this.apiClient});

  Future<List<Post>> getPostsList() async {
    List<Post> posts = [];

    // Pass only the endpoint, the base url is passed at initialization
    Response response = await apiClient.getData(kPostsUri);

    // Success
    if (response.statusCode == 200) {
      response.body
          .map((jsonUser) => posts.add(Post.fromJson(jsonUser)))
          .toList();
    } else {
      Get.snackbar("Error", "No se pudo obtener las publicaciones del servidor",
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.appCardColor);
    }

    return posts;
  }

  Future<List<Post>> getPostsListByUser(int userId) async {
    List<Post> posts = [];

    // Pass only the endpoint, the base url is passed at initialization
    Response response = await apiClient.getData(kGetUserPosts(userId));

    // Success
    if (response.statusCode == 200) {
      response.body
          .map((jsonUser) => posts.add(Post.fromJson(jsonUser)))
          .toList();
    } else {
      Get.snackbar("Error", "No se pudo obtener las publicaciones del servidor",
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.appCardColor);
    }

    return posts;
  }
}
