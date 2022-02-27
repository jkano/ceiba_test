import 'dart:io';

import 'package:ceiba_book/src/data/repositories/user_repository.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late UserController sut;
  late MockUserRepo mockUserRepo;
  final path = Directory.current.path;

  final List<User> users = [
    User(id: 0, name: "Jose", email: "jose@email.com", phone: "555-11-22"),
    User(
        id: 1,
        name: "Juan",
        email: "juan@email.com",
        phone: "555-33-44",
        website: "juan.mysite.com")
  ];

  final List<Map<String, dynamic>> jsonUserList = [
    {"id": 0, "name": "Jose", "email": "jose@email.com", "phone": "555-11-22"},
    {
      "id": 1,
      "name": "Juan",
      "email": "juan@email.com",
      "phone": "555-33-44",
      "website": "juan.mysite.com"
    },
  ];

  setUp(() {
    mockUserRepo = MockUserRepo();
    sut = UserController(userRepo: mockUserRepo);
    // Setup a hive box for testing
    Hive.init(path + '/test/hive');
  });

  group("[User]", () {
    test("User class empty", () {
      User _emptyUser = User();
      expect(_emptyUser, User());
    });

    test("User conversion from Json Map", () {
      User user0 = User.fromJson(jsonUserList[0]);
      expect(user0, users[0]);
      User user1 = User.fromJson(jsonUserList[1]);
      expect(user1, users[1]);
    });
  });

  group('[UserController]', () {
    test("Initial values are correct", () {
      expect(sut.isLoaded, false);
      expect(sut.userList, []);
    });

    test("Verify that getUserList is called when using getUserList", () async {
      when(() => mockUserRepo.getUserList()).thenAnswer((_) async => []);
      await sut.getUserList();
      verify(() => mockUserRepo.getUserList()).called(1);
    });

    test("Verify that correct user is retrieved from source", () async {
      when(() => mockUserRepo.getUserList()).thenAnswer((_) async => users);
      final getUsers = sut.getUserList();
      expect(sut.isLoaded, false);
      await getUsers;
      expect(sut.userList, users);
      expect(sut.isLoaded, true);
    });
  });
}
