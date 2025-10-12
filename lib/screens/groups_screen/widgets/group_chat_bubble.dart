import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/chat_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/text.dart';

class GroupChatBubble extends StatelessWidget {
  GroupChatBubble({
    required this.isComing, required this.message, required this.time, required this.imageUrl, required this.status, super.key,
  });
  final bool isComing;
  final String message;
  final String time;
  final String imageUrl;
  final String status;

  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: isComing
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.8,
            ),
            decoration: BoxDecoration(
              color: tContainerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomRight: isComing
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                topLeft: isComing ? const Radius.circular(0) : const Radius.circular(20),
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
                            const CircularProgressIndicator(color: Colors.amber),

                        errorWidget: (context, url, error) => const CircularProgressIndicator(color: Colors.red),
                      ),
                      const SizedBox(height: 15),
                      message.isNotEmpty ? Text(message) : const SizedBox(),
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
                      children: [
                        Text(time, style: TText.labelSmall),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          AssetsImages.chatStatusSVG,
                          colorFilter: const ColorFilter.linearToSrgbGamma(),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
}
