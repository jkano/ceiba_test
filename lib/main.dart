import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/config/routes/app_routes.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:ceiba_book/src/presentation/controllers/post_controller.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:ceiba_book/src/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ceiba_book/src/config/helper/dependencies.dart' as dependencies;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  await Hive.initFlutter();
  // Register all of our adapters
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Address>(AddressAdapter());
  Hive.registerAdapter<Geo>(GeoAdapter());
  Hive.registerAdapter<Company>(CompanyAdapter());
  await Hive.openBox<User>(kUserBox);
  runApp(const CeibaBook());
}

class CeibaBook extends StatelessWidget {
  const CeibaBook({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Find the User Controller and start getting the user list
    Get.find<UserController>().getUserList();
    // Find the Post Controller to initialize it
    Get.find<PostController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      getPages: AppRoutes.routes,
    );
  }
}
