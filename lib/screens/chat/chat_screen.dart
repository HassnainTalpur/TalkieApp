import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/controller/chat_controller.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/models/chat_model.dart';
import 'package:talkie/models/user_model.dart';
import 'package:talkie/screens/chat/widgets/chat_bubble.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.userModel});
  final UserModel userModel;
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(
    ProfileController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.name ?? '', style: TText.bodyLarge),
            Text('online', style: TText.labelMedium),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: tContainerColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(AssetsImages.chatMicSVG),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Type message ....',
                  hintStyle: TText.labelLarge,
                ),
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(AssetsImages.chatGallerySVG),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  chatController.sendMessages(
                    userModel.id!,
                    messageController.text,
                    profileController.currentUser.value.name!,
                  );
                  messageController.clear();
                }
              },
              child: Container(
                width: 25,
                height: 25,
                child: SvgPicture.asset(AssetsImages.chatSendSVG),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      reverse: false,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(
                          "senderId: ${snapshot.data![index].senderId}, "
                          "currentUserId: ${profileController.currentUser.value.id}",
                        );
                        return Obx(
                          () => ChatBubble(
                            isComing:
                                snapshot.data![index].senderId !=
                                profileController.currentUser.value.id,
                            message: snapshot.data![index].message!,
                            time: 'time',
                            imageUrl: '',
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
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
