import 'package:ceiba_book/src/data/repositories/posts_repository.dart';
import 'package:ceiba_book/src/domain/models/post.dart';
import 'package:ceiba_book/src/presentation/controllers/post_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepo extends Mock implements PostRepo {}

void main() {
  late PostController sut;
  late MockPostRepo mockPostRepo;

  final List<Post> postsUser0 = [
    Post(title: "Title 1 user 0", body: "Description of post #1"),
    Post(title: "Title 2 user 0", body: "Description of post #2"),
    Post(title: "Title 3 user 0", body: "Description of post #3"),
  ];

  final List<Post> postsUser1 = [
    Post(title: "Title 1 user 1", body: "Description of post #1"),
    Post(title: "Title 2 user 1", body: "Description of post #2"),
    Post(title: "Title 3 user 1", body: "Description of post #3"),
  ];

  final List<Map<String, dynamic>> jsonPostList = [
    {"title": "Title 1 user 0", "body": "Description of post #1"},
    {"title": "Title 1 user 1", "body": "Description of post #1"},
  ];

  final List<Post> allPosts = postsUser0 + postsUser1;

  setUp(() {
    mockPostRepo = MockPostRepo();
    sut = PostController(postRepo: mockPostRepo);
  });

  group("[Post]", () {
    test("Post class empty", () {
      Post _emptyPost = Post();
      expect(_emptyPost, Post());
    });

    test("Post conversion from Json Map", () {
      Post post0 = Post.fromJson(jsonPostList[0]);
      expect(post0, postsUser0[0]);
      Post post1 = Post.fromJson(jsonPostList[1]);
      expect(post1, postsUser1[0]);
    });
  });

  group('[PostController]', () {
    test("Initial values are correct", () {
      expect(sut.isLoaded, false);
      expect(sut.postList, []);
    });

    test("Verify that getPostListByUser is called when using getPostsByUserId",
        () async {
      when(() => mockPostRepo.getPostsListByUser(0))
          .thenAnswer((_) async => []);
      await sut.getPostsByUserId(0);
      verify(() => mockPostRepo.getPostsListByUser(0)).called(1);
    });

    test("Verify that posts are received for user 0", () async {
      when(() => mockPostRepo.getPostsListByUser(0))
          .thenAnswer((_) async => postsUser0);
      final getPostsUser0 = sut.getPostsByUserId(0);
      expect(sut.isLoaded, false);
      await getPostsUser0;
      expect(sut.postList, postsUser0);
      expect(sut.isLoaded, true);
    });

    test("Verify that posts are received for user 1", () async {
      when(() => mockPostRepo.getPostsListByUser(1))
          .thenAnswer((_) async => postsUser1);
      final getPostsUser1 = sut.getPostsByUserId(1);
      expect(sut.isLoaded, false);
      await getPostsUser1;
      expect(sut.postList, postsUser1);
      expect(sut.isLoaded, true);
    });

    test("Verify that all posts are received", () async {
      when(() => mockPostRepo.getPostsList()).thenAnswer((_) async => allPosts);
      final getAllPosts = sut.getPostsList();
      expect(sut.isLoaded, false);
      await getAllPosts;
      expect(sut.postList, allPosts);
      expect(sut.isLoaded, true);
    });
  });
}
