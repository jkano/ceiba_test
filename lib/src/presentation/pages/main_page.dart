import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/core/constants.dart';
import 'package:ceiba_book/src/presentation/controllers/user_controller.dart';
import 'package:ceiba_book/src/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> users = Get.find<UserController>().userList;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.appMainColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            kAppTitle1,
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            kAppTitle2,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    print("_build body");
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            GetBuilder<UserController>(builder: (userList) {
              users = [];
              users.addAll(userList.userList);

              return userList.isLoaded
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SearchableList<dynamic>(
                          searchTextController: _controller,
                          initialList: users,
                          builder: (dynamic user) => UserCard(user: user),
                          filter: _filterUserList,
                          emptyWidget: const EmptyView(),
                          inputDecoration: InputDecoration(
                            labelText: "Buscar usuario",
                            fillColor: Colors.white,
                            floatingLabelStyle:
                                const TextStyle(color: AppColors.appMainColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.appMainColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            child: Center(
                                child: CircularProgressIndicator(
                              color: AppColors.appMainColor,
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Loading users..."),
                          )
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }

  List<dynamic> _filterUserList(search) {
    print(search);
    return users
        .where((element) =>
            element.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.person_search,
          color: AppColors.appMainColor,
          size: 42,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'No user is found with this name',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
