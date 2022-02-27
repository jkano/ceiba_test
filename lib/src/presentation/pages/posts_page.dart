import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/core/utils/initials_from_name.dart';
import 'package:ceiba_book/src/presentation/controllers/post_controller.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostDetail extends StatelessWidget {
  final int userId;

  const PostDetail({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the user to get it's info
    var _user = Get.find<UserController>()
        .userList
        .where((dynamic element) => element.id == userId)
        .toList();

    var _currentUser = _user[0];

    // Get the posts made by the user
    Get.find<PostController>().getPostsByUserId(userId);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: GetBuilder<PostController>(builder: (postController) {
            return Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            const Color.fromARGB(255, 219, 231, 227),
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 24,
                            splashRadius: 20,
                            color: AppColors.appMainColor),
                      ),
                    ),
                    ClipPath(
                      clipper: const BackgroundBand(offset: 100),
                      child: Container(
                        color: const Color.fromARGB(255, 34, 143, 89),
                        width: double.maxFinite,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 203, 215, 221),
                          child: Text(
                            getInitialsFromName(_currentUser.name!),
                            style: const TextStyle(
                              fontSize: 50,
                              color: AppColors.appTextColor,
                            ),
                          ),
                          radius: 60,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _currentUser.name!,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 5),
                      Text(_currentUser.phone!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 5),
                      Text(_currentUser.email!),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.appTextColor,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "PUBLICACIONES",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.appMainColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: postController.isLoaded
                      ? ListView.builder(
                          itemCount: postController.postList.length,
                          itemBuilder: (context, index) {
                            return commentCard(
                                getInitialsFromName(_currentUser.name!),
                                postController.postList[index].title,
                                postController.postList[index].body);
                          },
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text("No hay publicaciones"),
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

Widget commentCard(String initials, String title, String message) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 243, 213),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 203, 215, 221),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: AppColors.appTextColor,
                    ),
                  ),
                  radius: 20,
                ),
              ),
              Expanded(
                child: Text(
                  title.capitalizeFirst!,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
          child: Text(message.capitalizeFirst!),
        ),
      ]),
    ),
  );
}

class BackgroundBand extends CustomClipper<Path> {
  final double offset;

  const BackgroundBand({this.offset = 0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(0, offset),
      Offset(size.width, 0),
      Offset(size.width, size.height / 2),
      Offset(0, size.height / 2 + offset)
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
