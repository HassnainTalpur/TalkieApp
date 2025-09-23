import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.contactName,
    required this.lastChat,
    required this.delieveryTime,
    required this.imageUrl,
  });

  final String imageUrl;
  final String contactName;
  final String lastChat;
  final String delieveryTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tContainerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: imageUrl != ''
                    ? NetworkImage(imageUrl)
                    : AssetImage(AssetsImages.boyPic),
                radius: 30,
              ),

              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contactName, style: TText.bodyLarge),
                  Text(lastChat, style: TText.labelSmall),
                ],
              ),
            ],
          ),
          Text(delieveryTime, style: TText.labelSmall),
        ],
      ),
    );
  }
}
