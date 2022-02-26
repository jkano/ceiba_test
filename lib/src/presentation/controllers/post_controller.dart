import 'package:ceiba_book/src/data/repositories/posts_repository.dart';
import 'package:ceiba_book/src/domain/models/post.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostRepo postRepo;

  PostController({required this.postRepo});

  List<dynamic> _postList = [];
  List<dynamic> get postList => _postList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  void _addPostsToList(List<dynamic> _posts) {
    _postList = [];
    List<dynamic> posts =
        _posts.map((dynamic post) => Post.fromJson(post)).toList();
    _postList.addAll(posts);
    _isLoaded = true;
  }

  Future<void> getPostsList() async {
    _isLoaded = false;

    // TODO: Only do this if there's nothing on the DB
    Response response = await postRepo.getPostsList();

    // Success
    if (response.statusCode == 200) {
      _addPostsToList(response.body);
      // Update the UI
      update();
    } else {
      _postList = [];
      // Update the UI
      update();
    }
  }

  Future<void> getPostsByUserId(int userId) async {
    _isLoaded = false;

    // TODO: Only do this if there's nothing on the DB
    Response response = await postRepo.getPostsListByUser(userId);

    // Success
    if (response.statusCode == 200) {
      _addPostsToList(response.body);
      print("got posts");
      // Update the UI
      update();
    } else {
      _postList = [];
      // Update the UI
      update();
    }
  }
}
