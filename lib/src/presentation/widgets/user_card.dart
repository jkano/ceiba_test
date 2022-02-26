import 'package:ceiba_book/src/config/routes/app_routes.dart';
import 'package:ceiba_book/src/core/colors.dart';
import 'package:ceiba_book/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.appCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(
              Icons.account_circle_rounded,
              color: AppColors.appMainColor,
              size: 32,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name!,
                      style: const TextStyle(
                          color: AppColors.appMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 20,
                          color: AppColors.appTextColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          user.phone!,
                          style: const TextStyle(
                            color: AppColors.appTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.mail,
                          size: 20,
                          color: AppColors.appMainColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          user.email!,
                          style: const TextStyle(
                            color: AppColors.appTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            child: const Text(
                              "VER PUBLICACIONES",
                              style: TextStyle(
                                color: AppColors.appMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () {
                              // Go to the posts page
                              Get.toNamed(AppRoutes.getPosts(user.id!));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
