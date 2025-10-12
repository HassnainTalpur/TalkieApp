import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/groupchat_controller.dart';
import '../../groups_screen/group_chat.dart';
import 'chat_tile.dart';

class GroupList extends StatelessWidget {
  GroupList({super.key});

  final GroupchatController groupchatController = Get.put(
    GroupchatController(),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: groupchatController.getGroupRooms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        print(
          '🔥⚠️ ⚠️ ⚠️ ⚠️  snapshot: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, error: ${snapshot.error}',
        );
        if (!snapshot.hasData) {
          print('⚠️ snapshot.hasData = false');
          return const Center(child: Text('No Groups Yet'));
        }

        final groupRooms = snapshot.data!;

        if (groupRooms.isEmpty) {
          print('⚠️ GroupRooms is empty');
          return const Center(child: Text('No Groups Yet'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await groupchatController.onRefresh();
          },
          child: ListView.builder(
            itemCount: groupRooms.length,
            itemBuilder: (context, index) => StreamBuilder(
              stream: groupchatController.getGroupStream(
                snapshot.data![index].id!,
              ),
              builder: (context, userSnap) {
                print(
                  '${userSnap.data}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
                );
                if (!userSnap.hasData) return const SizedBox();
                final groupUsers = userSnap.data!;

                String time = '';

                if (groupUsers.lastMessageTimestamp != null) {
                  final DateTime timestamp = DateTime.parse(
                    groupUsers.lastMessageTimestamp!,
                  );
                  time = DateFormat('hh:mm').format(timestamp);
                }
                return InkWell(
                  onTap: () {
                    Get.to(() => GroupChat(groupModel: groupUsers));
                  },
                  child: ChatTile(
                    contactName: groupUsers.name ?? '',
                    lastChat: groupUsers.lastMessage ?? '',
                    delieveryTime: time,
                    imageUrl: groupUsers.imageUrl ?? '',
                  ),
                );
              },
            ),
          ),
        );
      },
    ),
  );
}
