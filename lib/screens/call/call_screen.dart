import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../controller/call_controller.dart';
import '../../models/call_model.dart';
import '../../models/user_model.dart';

class VoiceCall extends StatelessWidget {
  final UserModel targetUser;

  const VoiceCall({required this.targetUser, super.key});

  @override
  Widget build(BuildContext context) {
    final callController = Get.find<CallController>();
    final currentUser = callController.auth.currentUser!;

    // Always make sure displayName is not empty
    final userName =
        (currentUser.displayName != null &&
            currentUser.displayName!.trim().isNotEmpty)
        ? currentUser.displayName!
        : currentUser.email?.split('@').first ??
              'User_${currentUser.uid.substring(0, 5)}';

    final callId = callController.getRoomId(currentUser.uid, targetUser.id!);

    print('🧠 Current userID: ${currentUser.uid}');
    print('🧠 Current userName: $userName');
    print('🧠 callID: $callId');

    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: 2023706659, // Your AppID
          appSign:
              'dbce8c67fd39b8c0045dd781456c1ea5fdcdaae31b3414808286420dd942e3a3',
          userID: currentUser.uid,
          userName: userName, // ✅ Always non-empty
          callID: callId,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
          events: ZegoUIKitPrebuiltCallEvents(
            onCallEnd: (event, defaultAction) async {
              String roomId = callController.getRoomId(
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
