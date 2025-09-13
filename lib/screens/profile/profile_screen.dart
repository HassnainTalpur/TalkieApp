import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/screens/profile/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed('/updateprofile');
            },
            icon: Icon(Icons.edit),
          ),
        ],
        actionsPadding: EdgeInsets.only(left: 8),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            UserInfo(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                authController.logOut();
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
