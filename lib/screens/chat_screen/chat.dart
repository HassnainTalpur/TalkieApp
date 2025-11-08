import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/auth_controller.dart';
import '../../controller/call_controller.dart';
import '../../controller/chat_controller.dart';
import '../../controller/connection_controller.dart';
import '../../controller/image_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/status_controller.dart';
import '../../models/user_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text.dart';
import '../call_screen/videocall.dart';
import '../call_screen/voicecall.dart';
import '../search_screen/widgets/display_pic.dart';
import '../user_profile/profile_screen.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/type_message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.userModel, super.key});
  final UserModel userModel;
  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.find<ChatController>();
  final AuthController authController = Get.find<AuthController>();
  final StatusController userStatusController = Get.find<StatusController>();
  final ImageController imageController = Get.find<ImageController>();
  final CallController callController = Get.find<CallController>();
  final ConnectionController connectionController =
      Get.find<ConnectionController>();
  @override
  Widget build(BuildContext context) {
    userStatusController.listenToUser(userModel.id!);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.toNamed('home');
        }
      },
      child: Scaffold(
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
            IconButton(
              onPressed: () {
                final bool isConnected =
                    connectionController.isConnectedToInternet.value;
                if (isConnected) {
                  callController.makeCall(
                    userModel.id!,
                    'audio',
                    userModel.name!,
                    userModel.profileImage,
                  );
                  Get.to(() => VoiceCall(targetUser: userModel));
                } else {
                  Get.snackbar(
                    'No Internet Connection',
                    'Check your Internet Connection and Try again',
                  );
                }
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {
                final bool isConnected =
                    connectionController.isConnectedToInternet.value;
                if (isConnected) {
                  callController.makeCall(
                    userModel.id!,
                    'video',
                    userModel.name!,
                    userModel.profileImage,
                  );
                  Get.to(() => VideoCall(targetUser: userModel));
                } else {
                  Get.snackbar(
                    'No Internet Connection',
                    'Check your Internet Connection and Try again',
                  );
                }
              },
              icon: const Icon(Icons.video_call),
            ),
          ],
          title: InkWell(
            onTap: () {
              Get.to(() => ProfileScreen(userModel: userModel));
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userModel.name ?? '', style: TText.bodyLarge),
                      Obx(() {
                        final status = userStatusController.status.value;
                        final lastChanged =
                            userStatusController.lastChanged.value;

                        if (status == 'online') {
                          return Text(
                            'Online',
                            style: TText.labelMedium.copyWith(
                              color: Colors.lightGreen,
                            ),
                          );
                        } else if (lastChanged != null) {
                          final formatted = DateFormat(
                            'MMM d, hh:mm a',
                          ).format(lastChanged);
                          return Text(
                            'Last seen $formatted',
                            style: TText.labelMedium,
                          );
                        } else {
                          return Text(
                            'Offline',
                            style: TText.labelMedium.copyWith(
                              color: Colors.red,
                            ),
                          );
                        }
                      }),
                    ],
                  ),
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
                    // Handle waiting state
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 👇 Instead of CircularProgressIndicator (which flashes)
                      return const SizedBox(); // keeps screen stable
                    }

                    // Handle errors safely
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // Handle no data
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Message Yet!'));
                    }

                    // ✅ Stable UI rendering
                    final messages = snapshot.data!;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];

                        // Handle timestamp safely
                        final timestamp = (msg.timestamp is Timestamp)
                            ? (msg.timestamp as Timestamp).toDate()
                            : (msg.timestamp is DateTime)
                            ? msg.timestamp as DateTime
                            : DateTime.now();

                        final formatTime = DateFormat(
                          'hh:mm a',
                        ).format(timestamp);

                        return Obx(
                          () => ChatBubble(
                            isComing:
                                msg.senderId !=
                                profileController.currentUser.value.id,
                            message: msg.message ?? '',
                            time: formatTime.toString(),
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

            Obx(
              () => imageController.image.value != null
                  ? Flexible(
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height *
                            0.50, // adaptive
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: tContainerColor,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: FileImage(
                              File(imageController.image.value!.path),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            TypeMessage(userModel: userModel),
          ],
        ),
      ),
    );
  }
}
