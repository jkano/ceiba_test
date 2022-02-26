import 'package:ceiba_book/src/data/repositories/user_repository.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final PostRepo userRepo;

  UserController({required this.userRepo});

  List<dynamic> _userList = [];
  List<dynamic> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList() async {
    _isLoaded = false;

    // TODO: Only do this if there's nothing on the DB
    Response response = await userRepo.getUserList();

    // Success
    if (response.statusCode == 200) {
      _userList = [];
      List<dynamic> users =
          response.body.map((dynamic user) => User.fromJson(user)).toList();
      _userList.addAll(users);
      _isLoaded = true;
      // Update the UI (like setState)
      update();
    } else {
      _userList = [];
      // Update the UI
      update();
    }
  }
}
