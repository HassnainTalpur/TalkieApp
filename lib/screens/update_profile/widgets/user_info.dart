import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/screens/search_screen/widgets/display_pic.dart';
import 'package:talkie/screens/update_profile/widgets/profile_button.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });
  final String name;
  final String email;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [DisplayPic(imageUrl: imageUrl, radius: 50)],
                ),
                SizedBox(height: 10),
                Text(name, style: TText.bodyMedium),
                Text(email, style: TText.labelSmall),
                SizedBox(height: 10),
                Row(
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
}
