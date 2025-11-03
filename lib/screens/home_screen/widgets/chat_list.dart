import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/chat_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/chatroom_model.dart';
import '../../chat/chat_screen.dart';
import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});
  final ChatController chatController = Get.find<ChatController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChatRoomModel>>(
    stream: chatController.chatRooms(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      print(
        '🔥 snapshot: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, error: ${snapshot.error}',
      );
      if (!snapshot.hasData) {
        print('⚠️ snapshot.hasData = false');
        return const Center(child: Text('No Chats Yet'));
      }

      final chatRooms = snapshot.data!;
      if (chatRooms.isEmpty) {
        print('⚠️ chatRooms is empty');
        return const Center(child: Text('No Chats Yet'));
      }

      print('✅ Showing ${chatRooms.length} chat rooms in UI');

      return RefreshIndicator(
        child: ListView.builder(
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            final chatRoom = chatRooms[index];
            final DateTime timestamp = DateTime.parse(
              chatRoom.lastMessageTimestamp!,
            );
            final String formatTime = DateFormat('hh:mm').format(timestamp);

            final currentUserId = chatController.auth.currentUser!.uid;
            final targetUserId = chatRoom.participants!.firstWhere(
              (id) => id != currentUserId,
              orElse: () => currentUserId,
            );

            return StreamBuilder(
              stream: chatController.getUserStream(targetUserId),
              builder: (builder, userSnap) {
                var unReadCount;
                if (!userSnap.hasData) {
                  return const SizedBox();
                }
                final otherUser = userSnap.data!;
                if (chatController.auth.currentUser!.uid ==
                    chatRoom.sender!.id) {
                  unReadCount = chatRoom.unReadMessNo!;
                }
                if (chatController.auth.currentUser!.uid ==
                    chatRoom.receiver!.id) {
                  unReadCount = chatRoom.toUnreadCount!;
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
