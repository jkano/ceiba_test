import 'package:ceiba_book/src/data/repositories/user_repository.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  List<User> _userList = [];
  List<User> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList() async {
    _isLoaded = false;
    _userList = await userRepo.getUserList();
    _isLoaded = true;

    // Update the UI (like setState)
    update();
  }

  Future<void> clearUserList() async {
    await userRepo.clearUsersSavedList();
    _userList = [];
    _isLoaded = false;

    // Update the UI (like setState)
    update();
  }
}
