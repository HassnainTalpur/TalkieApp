import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/models/user_model.dart';
import 'package:talkie/screens/update_profile/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            UserInfo(
              email: userModel.email ?? '',
              name: userModel.name ?? '',
              imageUrl: userModel.profileImage ?? '',
            ),
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
