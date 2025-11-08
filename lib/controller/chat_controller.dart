import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_model.dart';
import '../models/chatroom_model.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';
import 'image_controller.dart';
import 'lifecycle_service.dart';
import 'profile_controller.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = Uuid();
  final dio = Dio(
    BaseOptions(
      baseUrl:
          'https://notify-jade.vercel.app/', // Replace with your API base URL
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
        // Add other headers as needed
      },
    ),
  );

  final RxBool isLoading = false.obs;
  AuthController authController = Get.find<AuthController>();
  ImageController imageController = Get.find<ImageController>();
  ProfileController profileController = Get.find<ProfileController>();
  String getRoomId(String targetUserId) {
    final String currentUserId = auth.currentUser!.uid;
    if (currentUserId.compareTo(targetUserId) > 0) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  ({UserModel sender, UserModel receiver}) getSenderReceiverModel(
    UserModel targetUser,
  ) {
    final UserModel currentUser = profileController.currentUser.value;

    if (currentUser == null || currentUser.id == null) {
      throw Exception('❌ currentUser not loaded yet in ProfileController');
    }

    if (currentUser.id!.compareTo(targetUser.id!) > 0) {
      return (sender: currentUser, receiver: targetUser);
    } else {
      return (sender: targetUser, receiver: currentUser);
    }
  }

  Future<void> markChatAsRead(String roomId) async {
    // unReadMessNo belongs to sender
    // toUnreadCount belongs to receiver
    final roomRef = db.collection('chats').doc(roomId);
    final currentUserId = auth.currentUser!.uid;

    final roomSnapshot = await roomRef.get();
    if (!roomSnapshot.exists) {
      return;
    }

    final data = roomSnapshot.data()!;
    final senderId = data['sender']['id'];
    final receiverId = data['receiver']['id'];

    if (currentUserId == senderId) {
      await roomRef.update({'unReadMessNo': 0});
    } else if (currentUserId == receiverId) {
      await roomRef.update({'toUnreadCount': 0});
    }
  }

  Future<void> sendNotification(
    String token,
    String name,
    String message,
  ) async {
    if (token == '') {
      await AppLifecycleService().initNotification();
      return;
    }
    try {
      await dio.post(
        'send', // Endpoint for creating a post
        data: {"title": name, "body": message, "fcmToken": token},
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> sendMessages(
    String targetUserId,
    String message,
    String name,
    UserModel targetUser, {
    File? imageFile,
  }) async {
    imageController.image.value = null;
    isLoading.value = true;
    final roomId = getRoomId(targetUserId);
    final chatId = uuid.v6();
    final roomRef = db.collection('chats').doc(roomId);
    final snapshot = await roomRef.get();
    final senderReceiver = getSenderReceiverModel(targetUser);
    final token = targetUser.role ?? '';
    // unReadMessNo belongs to sender
    // toUnreadCount belongs to receiver
    final sender = senderReceiver.sender;

    final receiver = senderReceiver.receiver;

    if (!snapshot.exists) {
      final roomDetail = ChatRoomModel(
        id: roomId,
        participants: [auth.currentUser!.uid, targetUserId],
        sender: sender,
        unReadMessNo: 0, // Add this
        toUnreadCount: 0, // Add this
        receiver: receiver,
      );
      await db.collection('chats').doc(roomId).set(roomDetail.toJson());
    }
    String imageUrl = '';

    // Upload image if one exists
    if (imageFile != null) {
      print('🟢 Starting upload with path: ${imageFile.path}');

      try {
        // Convert File to Rx<File?> for the uploadImage method
        final Rx<File?> rxImage = Rx<File?>(imageFile);

        final uploadedUrl = await imageController.uploadImage(
          rxImage,
          profileController.auth.currentUser!.uid,
        );

        print('🟢 Upload complete, URL: $uploadedUrl');
        imageUrl = uploadedUrl ?? '';

        if (imageUrl.isEmpty) {
          print('🔴 WARNING: Image URL is empty after upload!');
        } else {
          print('🟢 Image URL set successfully: $imageUrl');
        }
      } catch (e) {
        print('🔴 UPLOAD ERROR: $e');
        Get.snackbar('Upload Error', e.toString());
      }
    } else {
      print('🟡 No image to upload');
    }
    print('🔵 Creating chat with imageUrl: "$imageUrl"');

    final newChat = ChatModel(
      readStatus: 'unread',
      imageUrl: imageUrl,
      id: chatId,
      timestamp: FieldValue.serverTimestamp(),
      message: message,
      senderName: name,
      receiverId: targetUserId,
      senderId: auth.currentUser!.uid,
    );

    try {
      final batch = db.batch();

      final roomRef = db.collection('chats').doc(roomId);
      final messageRef = roomRef
          .collection('messages')
          .doc(chatId); // Get current user ID
      final currentUserId = auth.currentUser!.uid;

      // If logged-in user is the consistent sender
      if (currentUserId == sender.id.toString()) {
        // User is the "real sender" of the chat room
        // → They sent a message, so increment receiver's unread count
        await roomRef.update({
          'toUnreadCount': FieldValue.increment(1),
          'unReadMessNo': 0,
        });
      } else if (currentUserId == receiver.id.toString()) {
        // User is the "real receiver" of the chat room
        // → They sent a message, so increment sender's unread count
        await roomRef.update({
          'unReadMessNo': FieldValue.increment(1),
          'toUnreadCount': 0,
        });
      }

      batch
        ..set(messageRef, newChat.toJson())
        ..update(roomRef, {
          'lastMessage': message,
          'lastMessageTimestamp': DateTime.now().toString(),
        });

      await batch.commit();
      print('🟢 Message saved to Firestore with imageUrl: "$imageUrl"');
      await sendNotification(token, name, message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      imageController.uploadedImageUrl.value = '';
    }
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    final String roomId = getRoomId(targetUserId);
    return db
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<List<ChatRoomModel>> chatRooms() {
    if (auth.currentUser == null) {
      return const Stream.empty();
    }
    return db
        .collection('chats')
        .where('participants', arrayContains: auth.currentUser!.uid)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatRoomModel.fromJson(data);
          }).toList(),
        );
  }

  Future<void> refreshChatRooms() async {
    // Small delay to simulate refresh
    await Future.delayed(const Duration(milliseconds: 500));
    update();
  }

  Stream<UserModel> getUserStream(String uid) => db
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((snapshot) => UserModel.fromJson(snapshot.data()!));
}
