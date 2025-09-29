import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/controller/chat_controller.dart';
import 'package:talkie/controller/image_controller.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/models/user_model.dart';
import 'package:talkie/screens/chat/widgets/chat_bubble.dart';
import 'package:talkie/screens/chat/widgets/type_message.dart';
import 'package:talkie/screens/search_screen/widgets/display_pic.dart';
import 'package:talkie/screens/user_profile/profile_screen.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.userModel});
  final UserModel userModel;
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.to(() => ProfileScreen(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: DisplayPic(imageUrl: userModel.profileImage ?? ''),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
        title: InkWell(
          onTap: () {
            Get.to(() => ProfileScreen(userModel: userModel));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.name ?? '', style: TText.bodyLarge),
                  Text('online', style: TText.labelMedium),
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
                stream: chatController.getMessages(userModel.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Message Yet!'));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        DateTime timestamp = DateTime.parse(
                          snapshot.data![index].timestamp!,
                        );
                        String formatTime = DateFormat(
                          'hh:mm',
                        ).format(timestamp);
                        return Obx(
                          () => ChatBubble(
                            isComing:
                                snapshot.data![index].senderId !=
                                profileController.currentUser.value.id,
                            message: snapshot.data![index].message!,
                            time: formatTime,
                            imageUrl: snapshot.data![index].imageUrl!,
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
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: FileImage(
                          File(imageController.image.value!.path),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          TypeMessage(userModel: userModel),
        ],
      ),
    );
  }
}
