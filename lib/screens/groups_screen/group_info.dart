import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../controller/groupchat_controller.dart';
import '../../models/groupchat_model.dart';
import 'widgets/group_info_header.dart';
import 'widgets/kick_member_tile.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({required this.groupModel, super.key});
  final GroupChatRoomModel groupModel;

  @override
  Widget build(BuildContext context) {
    final GroupchatController groupchatController = Get.put(
      GroupchatController(),
    );
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GroupInfoHeader(
              name: groupModel.name ?? '',
              imageUrl: groupModel.imageUrl ?? '',
            ),
            const Text('Group Members'),
            Expanded(
              child: StreamBuilder(
                stream: groupchatController.getGroupMembers(groupModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  print(
                    '🔥 snapshot: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, error: ${snapshot.error}',
                  );
                  if (!snapshot.hasData) {
                    print('⚠️ snapshot.hasData = false');
                    return const Center(child: Text('No Chats Yet'));
                  }

                  final data = snapshot.data!.data()!;
                  final List<dynamic> participants = data['participants'] ?? [];

                  return ListView.builder(
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      final member = participants[index];
                      return KickMemberTile(
                        groupModel: groupModel,
                        name: member['name'],
                        id: member['userId'],
                        role: member['role'],
                        imageUrl: member['imageUrl'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
