import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/auth_controller.dart';
import '../../controller/groupchat_controller.dart';
import '../../controller/image_controller.dart';
import '../../controller/profile_controller.dart';
import '../../models/groupchat_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text.dart';
import '../search_screen/widgets/display_pic.dart';

import 'group_info.dart';
import 'widgets/group_chat_bubble.dart';
import 'widgets/type_group_message.dart';

class GroupChat extends StatelessWidget {
  GroupChat({required this.groupModel, super.key});
  final GroupChatRoomModel groupModel;
  final TextEditingController messageController = TextEditingController();
  final GroupchatController groupchatController =
      Get.find<GroupchatController>();
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ImageController imageController = Get.find<ImageController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      leading: InkWell(
        onTap: () {
          Get.to(() => GroupInfo(groupModel: groupModel));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
          child: DisplayPic(imageUrl: groupModel.imageUrl ?? ''),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
      ],
      title: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groupModel.name ?? '', style: TText.bodyLarge),
                const Text('online', style: TText.labelMedium),
              ],
            ),
          ],
        ),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: StreamBuilder(
              stream: groupchatController.getMessages(groupModel.id!),
              builder: (context, snapshot) {
                // Prevent UI flicker during Firestore updates
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Message Yet!'));
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final t = msg.timestamp;

                    // ✅ Safe timestamp handling
                    DateTime timestamp;
                    if (t is Timestamp) {
                      timestamp = t.toDate();
                    } else if (t is String) {
                      timestamp = DateTime.tryParse(t) ?? DateTime.now();
                    } else {
                      timestamp = DateTime.now();
                    }

                    final formatTime = DateFormat('hh:mm').format(timestamp);

                    return Obx(
                      () => GroupChatBubble(
                        isComing:
                            msg.senderId !=
                            profileController.currentUser.value.id,
                        message: msg.message ?? '',
                        time: formatTime,
                        imageUrl: msg.imageUrl ?? '',
                        status: 'status',
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),

        // ✅ Optional image preview, unchanged
        Obx(
          () => imageController.image.value != null
              ? Container(
                  height: 500,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: tContainerColor,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: FileImage(File(imageController.image.value!.path)),
                    ),
                  ),
                )
              : const SizedBox(),
        ),

        TypeGroupMessage(groupChatModel: groupModel),
      ],
    ),
  );
}
