import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/screens/home_screen/widgets/chat_tile.dart';
import 'package:talkie/utils/constants/images.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offNamed('/chat');
      },
      child: ListView(
        children: [
          ChatTile(
            imageUrl: AssetsImages.boyPic,
            contactName: 'Mir',
            lastChat: 'Sned Noods',
            delieveryTime: '10:00 pm',
          ),
          ChatTile(
            imageUrl: AssetsImages.boyPic,
            contactName: 'Hasnain',
            lastChat: 'Pwease',
            delieveryTime: '4:00 am',
          ),
          ChatTile(
            imageUrl: AssetsImages.girlPic,
            contactName: 'Haider',
            lastChat: 'uwu',
            delieveryTime: '5:00 am',
          ),
          ChatTile(
            imageUrl: AssetsImages.girlPic,
            contactName: 'Mir',
            lastChat: 'Sned Noods',
            delieveryTime: '10:00 am',
          ),
        ],
      ),
    );
  }
}
