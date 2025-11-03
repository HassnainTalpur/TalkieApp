import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/chat_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/text.dart';
import 'image_picker_sheet.dart';

class TypeMessage extends StatelessWidget {
  TypeMessage({required this.userModel, super.key});

  final UserModel userModel;
  final RxString texting = ''.obs;
  final RxString photo = ''.obs;

  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController messageController = Get.put(
    TextEditingController(),
  );
  final ImageController imageController = Get.find<ImageController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: tContainerColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Stack(
                children: [
                  TextField(
                    onChanged: (value) {
                      texting.value = value;
                    },
                    controller: messageController,
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'Type message ....',
                      hintStyle: TText.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => imageController.image.value == null
                  ? InkWell(
                      onTap: () {
                        ImagePickerSheet(imageController);
                      },
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: chatController.isLoading.value
                            ? const CircularProgressIndicator()
                            : SvgPicture.asset(AssetsImages.chatGallerySVG),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        imageController.image.value = null;
                      },
                      child: const SizedBox(
                        width: 25,
                        height: 25,
                        child: Icon(Icons.delete),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Obx(
              () =>
                  texting.value.isNotEmpty ||
                      imageController.image.value != null
                  ? InkWell(
                      onTap: () {
                        profileController.getUserDetails();
                        if (profileController.currentUser.value.id == null) {
                          Get.snackbar(
                            'Error',
                            'User data not loaded yet. Please wait.',
                          );
                          profileController.getUserDetails();
                          return;
                        }
                        if (messageController.text.isNotEmpty ||
                            imageController.image.value != null) {
                          chatController.sendMessages(
                            userModel.id!,
                            messageController.text,
                            profileController.currentUser.value.name!,
                            userModel,
                          );

                          messageController.clear();

                          imageController.image.value = null;
                          texting.value = '';
                        }
                      },
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset(AssetsImages.chatSendSVG),
                      ),
                    )
                  : InkWell(
                      child: chatController.isLoading.value
                          ? const SizedBox()
                          : SizedBox(
                              width: 25,
                              height: 25,
                              child: SvgPicture.asset(AssetsImages.chatMicSVG),
                            ),
                    ),
            ),
          ],
        ),
      ),
    ],
  );
}
