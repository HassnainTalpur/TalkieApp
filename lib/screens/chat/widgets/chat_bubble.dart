import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isComing,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.status,
  });
  final bool isComing;
  final String message;
  final String time;
  final String imageUrl;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: isComing
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.8,
            ),
            decoration: BoxDecoration(
              color: tContainerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: isComing
                    ? Radius.circular(20)
                    : Radius.circular(0),
                bottomLeft: isComing ? Radius.circular(0) : Radius.circular(20),
              ),
            ),
            child: imageUrl == ''
                ? Text(message)
                : Column(
                    crossAxisAlignment: isComing
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Image.network(imageUrl),

                      SizedBox(height: 10),
                      Text(message),
                    ],
                  ),
          ),
          Row(
            mainAxisAlignment: isComing
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              isComing
                  ? Text(time, style: TText.labelSmall)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(time, style: TText.labelSmall),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          AssetsImages.chatStatusSVG,
                          colorFilter: ColorFilter.linearToSrgbGamma(),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
