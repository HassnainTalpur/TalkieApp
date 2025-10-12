import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/text.dart';
import '../../search_screen/widgets/display_pic.dart';
import 'profile_button.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    required this.name, required this.email, required this.imageUrl, super.key,
  });
  final String name;
  final String email;
  final String imageUrl;
  @override
  Widget build(BuildContext context) => Container(
      //height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [DisplayPic(imageUrl: imageUrl, radius: 50)],
                ),
                const SizedBox(height: 10),
                Text(name, style: TText.bodyMedium),
                Text(email, style: TText.labelSmall),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileButton(
                      buttonIcon: AssetsImages.chatSVG,
                      buttonText: 'Chat',
                    ),
                    ProfileButton(
                      color: Colors.green,
                      buttonIcon: AssetsImages.callSVG,
                      buttonText: 'Call',
                    ),
                    ProfileButton(
                      color: Colors.yellow,
                      buttonIcon: AssetsImages.videoSVG,
                      buttonText: 'Video',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
