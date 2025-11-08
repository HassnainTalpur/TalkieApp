import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../controller/call_controller.dart';
import '../../models/call_model.dart';
import '../../models/user_model.dart';

class VideoCall extends StatelessWidget {
  final UserModel targetUser;

  const VideoCall({required this.targetUser, super.key});

  @override
  Widget build(BuildContext context) {
    final callController = Get.find<CallController>();
    final currentUser = callController.auth.currentUser!;
    final appId = int.parse(dotenv.env['ZEGO_APP_ID']!);
    final appSign = dotenv.env['ZEGO_APP_SIGN']!;
    // Always make sure displayName is not empty
    final userName =
        (currentUser.displayName != null &&
            currentUser.displayName!.trim().isNotEmpty)
        ? currentUser.displayName!
        : currentUser.email?.split('@').first ??
              'User_${currentUser.uid.substring(0, 5)}';

    final callId = callController.getRoomId(currentUser.uid, targetUser.id!);
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: appId, // Your AppID
          appSign: appSign,
          userID: currentUser.uid,
          userName: userName, // ✅ Always non-empty
          callID: callId,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          events: ZegoUIKitPrebuiltCallEvents(
            onCallEnd: (event, defaultAction) async {
              final String roomId = callController.getRoomId(
                currentUser.uid,
                targetUser.id!,
              );
              await callController.endCall(
                CallModel(receiverId: targetUser.id, roomId: roomId),
              );
              defaultAction.call();
            },
          ),
        ),
      ),
    );
  }
}
