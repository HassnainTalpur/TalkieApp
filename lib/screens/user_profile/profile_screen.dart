import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../models/user_model.dart';
import '../update_profile/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.userModel, super.key});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Back'),
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                authController.logOut();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
