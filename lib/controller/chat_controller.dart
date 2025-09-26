import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/models/chat_model.dart';
import 'package:talkie/models/chatroom_model.dart';
import 'package:talkie/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = Uuid();

  ProfileController profileController = Get.put(ProfileController());
  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId.compareTo(targetUserId) > 0) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  Future<void> sendMessages(
    String targetUserId,
    String message,
    String name,
    UserModel targetUser,
  ) async {
    final roomId = getRoomId(targetUserId);
    final chatid = uuid.v6();
    var newChat = ChatModel(
      id: chatid,
      timestamp: DateTime.now().toString(),
      message: message,
      senderName: name,
      receiverId: targetUserId,
      senderId: auth.currentUser!.uid,
    );
    var roomDetails = ChatRoomModel(
      id: roomId,
      participants: [auth.currentUser!.uid, targetUserId],
      sender: targetUser,
      receiver: profileController.currentUser.value,
      lastMessage: message,
      lastMessageTimestamp: DateTime.now().toString(),
    );
    try {
      await db.collection('chats').doc(roomId).set(roomDetails.toJson());
      await db
          .collection('chats')
          .doc(roomId)
          .collection('messages')
          .doc(chatid)
          .set(newChat.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<List<ChatRoomModel>> chatRooms() {
    return db
        .collection('chats')
        .where('participants', arrayContains: auth.currentUser!.uid)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatRoomModel.fromJson(data);
          }).toList();
        });
  }

  Future<void> refreshChatRooms() async {
    // Small delay to simulate refresh
    await Future.delayed(const Duration(milliseconds: 500));

    // Optionally, you could force a fetch by clearing cache
    // but since .snapshots() auto-updates, this is often enough
    update();
  }

  Stream<UserModel> getUserStream(String uid) {
    return db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }
}
