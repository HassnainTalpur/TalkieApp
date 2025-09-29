import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talkie/controller/chat_controller.dart';
import 'package:talkie/models/chatroom_model.dart';
import 'package:talkie/screens/chat/chat_screen.dart';
import 'package:talkie/screens/home_screen/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});
  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRoomModel>>(
      stream: chatController.chatRooms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        print(
          "🔥 snapshot: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, error: ${snapshot.error}",
        );
        if (!snapshot.hasData) {
          print("⚠️ snapshot.hasData = false");
          return const Center(child: Text('No Chats Yet'));
        }

        final chatRooms = snapshot.data!;
        if (chatRooms.isEmpty) {
          print("⚠️ chatRooms is empty");
          return const Center(child: Text('No Chats Yet'));
        }

        print("✅ Showing ${chatRooms.length} chat rooms in UI");

        return RefreshIndicator(
          child: ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              DateTime timestamp = DateTime.parse(
                chatRoom.lastMessageTimestamp!,
              );
              String formatTime = DateFormat('hh:mm').format(timestamp);
              final currentUserId = chatController.auth.currentUser!.uid;
              final targetUserId = chatRoom.participants!.firstWhere(
                (id) => id != currentUserId,
                orElse: () => currentUserId,
              );

              return StreamBuilder(
                stream: chatController.getUserStream(targetUserId),
                builder: (builder, userSnap) {
                  if (!userSnap.hasData) return const SizedBox();
                  final otherUser = userSnap.data!;

                  return InkWell(
                    onTap: () {
                      Get.to(() => ChatScreen(userModel: otherUser));
                    },
                    child: ChatTile(
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
}
