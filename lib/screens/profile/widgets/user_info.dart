import 'package:flutter/material.dart';
import 'package:talkie/screens/profile/widgets/profile_button.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

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
                  children: [Image.asset(AssetsImages.boyPic)],
                ),
                Text('YOUR NAME', style: TText.bodyMedium),
                Text('YOUR EMAIL@hotmail.com', style: TText.labelMedium),
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
