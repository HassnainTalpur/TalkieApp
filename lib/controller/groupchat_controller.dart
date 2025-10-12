import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_model.dart';
import '../models/group_participants.dart';
import '../models/groupchat_model.dart';
import 'image_controller.dart';
import 'profile_controller.dart';

class GroupchatController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uid = Uuid();

  final ProfileController profileController = Get.put(ProfileController());
  final ImageController imageController = Get.put(ImageController());
  RxBool isLoading = false.obs;
  RxList<GroupParticipant> selectedContacts = <GroupParticipant>[].obs;
  RxList<String> participantIds = <String>[].obs;

  void toggleContact(
    String id,
    bool isSelected,
    String? role,
    String? name,
    String? about,
    String? imageUrl,
  ) {
    if (isSelected) {
      if (!selectedContacts.any((p) => p.userId == id)) {
        selectedContacts.add(
          GroupParticipant(
            userId: id,
            name: name,
            about: about,
            imageUrl: imageUrl,
            role: 'member',
            joinedAt: DateTime.now().toString(),
          ),
        );

        participantIds.add(id);
      }
    } else {
      selectedContacts.removeWhere((p) => p.userId == id);
      participantIds.remove(id);
    }
  }

  bool isSelected(String id) => selectedContacts.any((p) => p.userId == id);

  Future<void> createGroupChat(String groupName) async {
    final groupRoomId = uid.v6();

    if (!selectedContacts.contains(auth.currentUser!.uid)) {
      selectedContacts.add(
        GroupParticipant(
          userId: auth.currentUser!.uid,
          role: 'admin',
          name: profileController.currentUser.value.name,
          joinedAt: DateTime.now().toString(),
        ),
      );
      participantIds.add(auth.currentUser!.uid);
    }

    if (imageController.image.value != null) {
      await imageController.uploadImage(imageController.image, groupRoomId);
    }
    final groupRoomdetails = GroupChatRoomModel(
      id: groupRoomId,
      name: groupName,
      imageUrl: imageController.image.value != null
          ? imageController.uploadedImageUrl.value
          : null,
      createdAt: DateTime.now().toString(),
      createdBy: auth.currentUser!.displayName,
      participants: selectedContacts,
      participantIds: participantIds,
    );

    try {
      await db
          .collection('groupchats')
          .doc(groupRoomId)
          .set(groupRoomdetails.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessages(String message, String groupRoomId) async {
    isLoading.value = true;
    final chatId = uid.v7();

    String uploadedUrl = '';

    if (imageController.image.value != null) {
      // Wait for Cloudinary upload to finish
      await imageController.uploadImage(imageController.image, chatId);
      uploadedUrl = imageController.uploadedImageUrl.value;
      print('✅ Image uploaded: $uploadedUrl');
    }

    // Construct chat object AFTER upload completes
    final newChat = ChatModel(
      id: chatId,
      imageUrl: uploadedUrl,
      message: message,
      timestamp: DateTime.now().toString(),
      senderId: auth.currentUser!.uid,
    );

    try {
      await db.collection('groupchats').doc(groupRoomId).update({
        'lastMessage': message.isEmpty ? '📷 Photo' : message,
        'lastMessageSenderId': auth.currentUser!.uid,
        'lastMessageTimestamp': DateTime.now().toString(),
      });

      await db
          .collection('groupchats')
          .doc(groupRoomId)
          .collection('messages')
          .doc(chatId)
          .set(newChat.toJson());

      print('✅ Message saved to Firestore with imageUrl: $uploadedUrl');
    } catch (e) {
      print('❌ Error sending group message: $e');
    } finally {
      // Reset after upload completes
      imageController.image.value = null;
      imageController.uploadedImageUrl.value = '';
      isLoading.value = false;
    }
  }

  Stream<GroupChatRoomModel> getGroupStream(String uid) => db
      .collection('groupchats')
      .doc(uid)
      .snapshots()
      .map((snapshot) => GroupChatRoomModel.fromJson(snapshot.data()!));

  Stream getMessages(String groupId) => db
      .collection('groupchats')
      .doc(groupId)
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList(),
      );

  Stream<List<GroupChatRoomModel>> getGroupRooms() {
    if (auth.currentUser == null) {
      return const Stream.empty();
    }
    return db
        .collection('groupchats')
        .where('participantIds', arrayContains: auth.currentUser!.uid)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return GroupChatRoomModel.fromJson(data);
          }).toList(),
        );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupMembers(
    String groupRoomId,
  ) => db.collection('groupchats').doc(groupRoomId).snapshots();
  Future<void> kickMember(String id, String groupRoomId) async {
    try {
      final groupSnapshot = await db
          .collection('groupchats')
          .doc(groupRoomId)
          .get();

      if (!groupSnapshot.exists) {
        print('❌ Group not found');
        return;
      }

      final data = groupSnapshot.data();
      if (data == null) {
        print('❌ No group data');
        return;
      }

      // Get and modify participants list
      final members = List<Map<String, dynamic>>.from(
        data['participants'] ?? [],
      )..removeWhere((m) => m['userId'] == id);

      // Get and modify participantIds list
      final memberIds = List<String>.from(data['participantIds'] ?? [])
        ..removeWhere((e) => e == id);

      // Update both arrays in a single Firestore write
      await db.collection('groupchats').doc(groupRoomId).update({
        'participants': members,
        'participantIds': memberIds,
      });

      print('✅ Member $id removed successfully');
    } catch (e) {
      print('❌ Error kicking member: $e');
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    update();
  }
}
