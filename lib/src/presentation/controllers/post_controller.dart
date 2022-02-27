import 'package:ceiba_book/src/data/repositories/posts_repository.dart';
import 'package:ceiba_book/src/domain/models/post.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostRepo postRepo;

  PostController({required this.postRepo});

  List<dynamic> _postList = [];
  List<dynamic> get postList => _postList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPostsList() async {
    _isLoaded = false;
    _postList = await postRepo.getPostsList();
    _isLoaded = true;

    // Update the UI
    update();
  }

  Future<void> getPostsByUserId(int userId) async {
    _isLoaded = false;
    _postList = await postRepo.getPostsListByUser(userId);
    _isLoaded = true;

    // Update the UI
    update();
  }
}
