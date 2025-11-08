import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/chat_controller.dart';
import '../../../controller/connection_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/chatroom_model.dart';
import '../../chat_screen/chat.dart';
import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});
  final ChatController chatController = Get.find<ChatController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final ConnectionController connectionController =
      Get.find<ConnectionController>();
  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChatRoomModel>>(
    stream: chatController.chatRooms(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData) {
        return const Center(child: Text('No Chats Yet'));
      }

      final chatRooms = snapshot.data!;
      if (chatRooms.isEmpty) {
        return const Center(child: Text('No Chats Yet'));
      }

      return RefreshIndicator(
        child: ListView.builder(
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            final chatRoom = chatRooms[index];
            final String? timestampStr = chatRoom.lastMessageTimestamp;
            String formatTime = '';

            if (timestampStr != null && timestampStr.isNotEmpty) {
              final DateTime timestamp = DateTime.parse(timestampStr);
              formatTime = DateFormat('hh:mm').format(timestamp);
            }
            final currentUserId = chatController.auth.currentUser!.uid;
            final targetUserId = chatRoom.participants!.firstWhere(
              (id) => id != currentUserId,
              orElse: () => currentUserId,
            );

            return StreamBuilder(
              stream: chatController.getUserStream(targetUserId),
              builder: (builder, userSnap) {
                int unReadCount;
                if (!userSnap.hasData) {
                  return const SizedBox();
                }
                final otherUser = userSnap.data!;
                if (chatRoom.sender != null &&
                    chatController.auth.currentUser!.uid ==
                        chatRoom.sender!.id) {
                  unReadCount = chatRoom.unReadMessNo ?? 0;
                } else if (chatRoom.receiver != null &&
                    chatController.auth.currentUser!.uid ==
                        chatRoom.receiver!.id) {
                  unReadCount = chatRoom.toUnreadCount ?? 0;
                } else {
                  unReadCount = 0;
                }
                return InkWell(
                  onTap: () {
                    Get.to(() => ChatScreen(userModel: otherUser));
                  },
                  child: ChatTile(
                    unReadCount: unReadCount,
                    contactName: otherUser.name ?? '',
                    lastChat: chatRoom.lastMessage ?? '',
                    delieveryTime: formatTime,
                    imageUrl: otherUser.profileImage ?? '',
                  ),
                );
              },
            );
          },
        ),
        onRefresh: () async {
          await chatController.refreshChatRooms();
        },
      );
    },
  );
}
