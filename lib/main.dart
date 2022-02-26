import 'package:ceiba_book/src/config/routes/app_routes.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:ceiba_book/src/presentation/pages/main_page.dart';
import 'package:ceiba_book/src/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ceiba_book/src/config/helper/dependencies.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const CeibaBook());
}

class CeibaBook extends StatelessWidget {
  const CeibaBook({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Find the User Controller and start getting the user list
    Get.find<UserController>().getUserList();

    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostDetail(userId: 0),
      //getPages: AppRoutes.routes,
    );
  }
}
