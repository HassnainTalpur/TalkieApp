import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/chat_controller.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
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

  final ChatController chatController = Get.put(ChatController());
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
            padding: EdgeInsets.all(5),
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
                      CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),

                        errorWidget: (context, url, error) {
                          return CircularProgressIndicator();
                        },
                      ),
                      SizedBox(height: 15),
                      message.isNotEmpty ? Text(message) : SizedBox(),
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
