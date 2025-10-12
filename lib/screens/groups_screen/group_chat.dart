import 'dart:io';

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
  final GroupchatController groupchatController = Get.put(
    GroupchatController(),
  );
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) => Scaffold(
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     groupchatController.sendMessages('Agggg', groupModel.id!);
    //   },
    // ),
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      leading: InkWell(
        onTap: () {
          Get.to(() => GroupInfo(groupModel: groupModel));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: DisplayPic(imageUrl: groupModel.imageUrl ?? ''),
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
      ],
      title: InkWell(
        onTap: () {
          // Get.to(() => ProfileScreen(userModel: userModel));
        },
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Message Yet!'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final DateTime timestamp = DateTime.parse(
                        snapshot.data![index].timestamp!,
                      );
                      final String formatTime = DateFormat(
                        'hh:mm',
                      ).format(timestamp);
                      return Obx(
                        () => GroupChatBubble(
                          isComing:
                              snapshot.data![index].senderId !=
                              profileController.currentUser.value.id,
                          message: snapshot.data![index].message! ?? '',
                          time: formatTime,
                          imageUrl: snapshot.data![index].imageUrl ?? '',
                          status: 'status',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),

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
