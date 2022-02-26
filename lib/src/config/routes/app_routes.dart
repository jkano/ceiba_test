import 'package:ceiba_book/src/presentation/pages/main_page.dart';
import 'package:ceiba_book/src/presentation/pages/posts_page.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static const String initial = "/";
  static const String posts = "/posts";

  static String getInitial() => initial;
  static String getPosts(int userId) => "$posts?userId=$userId";

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const MainPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: posts,
      page: () {
        var userId = Get.parameters["userId"];
        return PostDetail(userId: int.parse(userId!));
      },
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
