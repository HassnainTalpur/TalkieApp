import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talkie/models/chat_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = Uuid();

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
  ) async {
    final roomId = await getRoomId(targetUserId);
    final chatid = uuid.v6();
    var newChat = ChatModel(
      id: chatid,
      message: message,
      senderName: name,
      receiverId: targetUserId,
      senderId: auth.currentUser!.uid,
    );
    try {
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
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
