import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import '../models/call_model.dart';
import '../models/user_model.dart';
import '../screens/call_screen/videocall.dart';
import '../screens/call_screen/voicecall.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid();
  final RxString activeCallRoomId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    gettingCall().listen((List<CallModel> callList) {
      if (callList.isEmpty) {
        // No active calls — close snackbar if any
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        return;
      }

      final callData = callList.first;

      // Prevent showing snackbar multiple times for same call
      if (activeCallRoomId.value == callData.roomId) {
        return;
      }

      // Only show if ringing
      if (callData.status == 'ringing') {
        activeCallRoomId.value = callData.roomId!;
        if (callData.type == 'audio') {
          audioCallNotification(callData);
        } else {
          vidoCallNotification(callData);
        }
      } else {
        // If accepted or ended, close snackbar
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
          activeCallRoomId.value = '';
        }
      }
    });
  }

  Future<void> vidoCallNotification(CallModel callData) async {
    await db
        .collection('notifications')
        .doc(callData.receiverId)
        .collection('calls')
        .doc(callData.roomId)
        .update({'status': 'accepted'});
    Get.snackbar(
      callData.callerName ?? 'Incoming Call',
      'Incoming Video Call',
      duration: const Duration(seconds: 20),
      barBlur: 0,
      backgroundColor: Colors.grey[900]!,
      isDismissible: false,
      icon: const Icon(Icons.call, color: Colors.white),
      onTap: (snack) async {
        await db
            .collection('notifications')
            .doc(callData.receiverId)
            .collection('calls')
            .doc(callData.roomId)
            .update({'status': 'accepted'});

        await Get.closeCurrentSnackbar();
        activeCallRoomId.value = '';
        await Get.to(
          () => VideoCall(
            targetUser: UserModel(
              id: callData.callerId,
              name: callData.callerName,
              email: callData.callerEmail,
            ),
          ),
        );
      },

      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text('End Call', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      callData.callerName ?? 'Incoming Call',
      'Incoming Audio Call',
      duration: const Duration(seconds: 20),
      barBlur: 0,
      backgroundColor: Colors.grey[900]!,
      isDismissible: false,
      icon: const Icon(Icons.call, color: Colors.white),
      onTap: (snack) async {
        await db
            .collection('notifications')
            .doc(callData.receiverId)
            .collection('calls')
            .doc(callData.roomId)
            .update({'status': 'accepted'});

        await Get.closeCurrentSnackbar();
        activeCallRoomId.value = '';
        await Get.to(
          () => VoiceCall(
            targetUser: UserModel(
              id: callData.callerId,
              name: callData.callerName,
              email: callData.callerEmail,
            ),
          ),
        );
      },

      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text('End Call', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  String getRoomId(String senderId, String recieverId) {
    if (senderId.compareTo(recieverId) > 0) {
      return senderId + recieverId;
    }
    return recieverId + senderId;
  }

  Future<void> makeCall(
    String recieverId,
    String type,
    String name,
    String? profileImage,
  ) async {
    final senderId = auth.currentUser!.uid;
    final callId = uuid.v6();
    final id = getRoomId(senderId, recieverId);
    final newCall = CallModel(
      time: DateTime.now().toString(),
      callerName: name,
      dp: profileImage ?? '',
      receiverId: recieverId,
      callerId: senderId,
      roomId: id,
      type: type,
      status: 'ringing',
    );
    await db
        .collection('notifications')
        .doc(recieverId)
        .collection('calls')
        .doc(id)
        .set(newCall.toJson());

    await db
        .collection('users')
        .doc(senderId)
        .collection('calls')
        .doc(callId)
        .set(newCall.toJson());

    await db
        .collection('users')
        .doc(recieverId)
        .collection('calls')
        .doc(callId)
        .set(newCall.toJson());

    Future.delayed(const Duration(seconds: 20), () {
      endCall(newCall);
    });
  }

  Stream<List<CallModel>> gettingCall() {
    final user = auth.currentUser;
    if (user == null) {
      debugPrint('⚠️ No user logged in yet — returning empty call stream');
      return const Stream.empty();
    }

    return db
        .collection('notifications')
        .doc(user.uid)
        .collection('calls')
        .snapshots()
        .map(
          (event) =>
              event.docs.map((doc) => CallModel.fromJson(doc.data())).toList(),
        );
  }

  Future endCall(CallModel call) async {
    await db
        .collection('notifications')
        .doc(call.receiverId)
        .collection('calls')
        .doc(call.roomId)
        .delete();
  }

  Stream<List<CallModel>> getCallHistory() => db
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('calls')
      .orderBy('time', descending: true)
      .snapshots()
      .map(
        (events) =>
            events.docs.map((doc) => CallModel.fromJson(doc.data())).toList(),
      );
}
