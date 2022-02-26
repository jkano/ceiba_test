import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/data/repositories/user_repository.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  List<User> _userList = [];
  List<User> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList() async {
    _isLoaded = false;

    final box = await Hive.openBox<User>(kUserBox);
    _userList = box.values.toList();

    if (_userList.isEmpty) {
      // We dont have any user stored internally, get them from the server
      print("No users stored, getting users from server");

      Response response = await userRepo.getUserList();

      // Success
      if (response.statusCode == 200) {
        response.body
            .map((jsonUser) => _userList.add(User.fromJson(jsonUser)))
            .toList();
        // Add users to Hive box
        box.addAll(_userList);
        _isLoaded = true;
      }
    } else {
      // We have users stored internally
      print("Using users stored on local storage");
      _isLoaded = true;
    }

    // Update the UI (like setState)
    update();
  }
}
