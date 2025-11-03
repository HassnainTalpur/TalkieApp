import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/groupchat_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../models/groupchat_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/text.dart';
import '../../chat/widgets/image_picker_sheet.dart';

class TypeGroupMessage extends StatelessWidget {
  TypeGroupMessage({required this.groupChatModel, super.key});

  final GroupChatRoomModel groupChatModel;
  final RxString texting = ''.obs;
  final RxString photo = ''.obs;

  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController messageController = Get.put(
    TextEditingController(),
  );
  final ImageController imageController = Get.find<ImageController>();
  final GroupchatController groupchatController =
      Get.find<GroupchatController>();

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
                        child: groupchatController.isLoading.value
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
                        if (messageController.text.isNotEmpty ||
                            imageController.image.value != null) {
                          print(
                            '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${messageController.text}',
                          );

                          print(
                            '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${imageController.image.value}',
                          );
                          groupchatController.sendMessages(
                            messageController.text,
                            groupChatModel.id!,
                          );
                          print(
                            '@@@@@@@@@@@@@@@@@@@@@@@@2222222222222222${imageController.image.value}',
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
                      child: groupchatController.isLoading.value
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
