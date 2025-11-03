import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/contact_controller.dart';
import '../../controller/groupchat_controller.dart';
import '../../models/user_model.dart';
import '../update_profile/update_profile.dart';
import 'widgets/add_member_tile.dart';

class CreateGroup extends StatelessWidget {
  CreateGroup({super.key});
  final GroupchatController groupchatController =
      Get.find<GroupchatController>();
  final ContactController contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    final List userList = contactController.userList
        .where((user) => user.id != contactController.auth.currentUser!.uid)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Group Members'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => UpdateGroup());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            final UserModel user = userList[index];

            return AddMemberTile(
              imageUrl: user.profileImage,
              role: user.role,
              name: user.name,
              id: user.id!,
              about: user.about ?? '',
            );
          },
        ),
      ),
    );
  }
}
