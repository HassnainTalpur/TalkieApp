import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../search_screen/widgets/display_pic.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.contactName,
    required this.lastChat,
    required this.delieveryTime,
    required this.imageUrl,
    required this.unReadCount,
    super.key,
  });

  final String imageUrl;
  final String contactName;
  final String lastChat;
  final String delieveryTime;
  final int unReadCount;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: tContainerColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              DisplayPic(imageUrl: imageUrl),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contactName, style: TText.bodyLarge),
                    Text(lastChat, style: TText.labelSmall, maxLines: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            unReadCount == 0
                ? const SizedBox()
                : CircleAvatar(
                    radius: 10,
                    backgroundColor: tPrimaryColor,
                    child: Text(
                      unReadCount.toString(),
                      textAlign: TextAlign.center,
                      style: TText.labelMedium.copyWith(color: Colors.white),
                    ),
                  ),
            const SizedBox(width: 5),
            Text(delieveryTime, style: TText.labelSmall),
          ],
        ),
      ],
    ),
  );
}
