import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetail extends StatelessWidget {
  final int userId;

  const PostDetail({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    var user = Get.find<UserController>()
        .userList
        .where((dynamic element) => element.id == userId)
        .toList();
    */

    var items = [];
    items = List<String>.generate(10, (i) => 'Title $i');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: const BackgroundBand(offset: 100),
                  child: Container(
                    color: const Color.fromARGB(255, 34, 143, 89),
                    width: double.maxFinite,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 200,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 203, 215, 221),
                      child: Text(
                        'LG',
                        style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Leanne Graham",
                style: TextStyle(
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
                children: const [
                  Icon(Icons.phone),
                  SizedBox(width: 5),
                  Text("1-770-736-8031 x56442"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.email),
                  SizedBox(width: 5),
                  Text("Sincere@april.biz"),
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
              child: items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text("No hay publicaciones"),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return commentCard(
                            "sint suscipit perspiciatis velit dolorum rerum ipsa laboriosam odio",
                            "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio\nsuscipit nam nisi quo aperiam aut\nasperiores eos fugit maiores voluptatibus quia\nvoluptatem quis ullam qui in alias quia est\nconsequatur magni mollitia accusamus ea nisi voluptate dicta");
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget commentCard(String title, String message) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 243, 213),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 203, 215, 221),
                  child: Text(
                    'LG',
                    style: TextStyle(
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
