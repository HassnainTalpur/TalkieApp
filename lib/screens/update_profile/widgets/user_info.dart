import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/call_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/text.dart';
import '../../call/call_screen.dart';
import '../../call/videocall_screen.dart';
import '../../search_screen/widgets/display_pic.dart';
import 'profile_button.dart';

class UserInfo extends StatelessWidget {
  UserInfo({
    required this.name,
    required this.email,
    required this.imageUrl,
    super.key,
    required this.targetUser,
  });
  final String name;
  final String email;
  final String imageUrl;
  final UserModel targetUser;

  final CallController callController = Get.find<CallController>();

  final ProfileController profileController = Get.find<ProfileController>();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const ProfileButton(
                      buttonIcon: AssetsImages.chatSVG,
                      buttonText: 'Chat',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      callController.makeCall(
                        targetUser.id!,
                        'audio',
                        targetUser.name!,
                        targetUser.profileImage,
                      );
                      Get.to(() => VoiceCall(targetUser: targetUser));
                    },
                    child: const ProfileButton(
                      color: Colors.green,
                      buttonIcon: AssetsImages.callSVG,
                      buttonText: 'Call',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      callController.makeCall(
                        targetUser.id!,
                        'video',
                        targetUser.name!,
                        targetUser.profileImage,
                      );
                      Get.to(() => VideoCall(targetUser: targetUser));
                    },
                    child: const ProfileButton(
                      color: Colors.yellow,
                      buttonIcon: AssetsImages.videoSVG,
                      buttonText: 'Video',
                    ),
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
