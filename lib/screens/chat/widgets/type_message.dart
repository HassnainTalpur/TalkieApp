import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkie/controller/chat_controller.dart';
import 'package:talkie/controller/image_controller.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/models/user_model.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class TypeMessage extends StatelessWidget {
  TypeMessage({super.key, required this.userModel});

  final UserModel userModel;
  RxString texting = ''.obs;
  RxString photo = ''.obs;

  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController messageController = Get.put(
    TextEditingController(),
  );
  final ImageController imageController = Get.put(ImageController());
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: tContainerColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      onChanged: (value) {
                        texting.value = value;
                      },
                      controller: messageController,
                      decoration: InputDecoration(
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
                          imageController.imagePicker(ImageSource.gallery);
                        },
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: chatController.isLoading.value
                              ? CircularProgressIndicator()
                              : SvgPicture.asset(AssetsImages.chatGallerySVG),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          imageController.image.value = null;
                        },
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Icon(Icons.delete),
                        ),
                      ),
              ),
              SizedBox(width: 10),
              Obx(
                () =>
                    texting.value.isNotEmpty ||
                        imageController.image.value != null
                    ? InkWell(
                        onTap: () {
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
                            ? SizedBox()
                            : SizedBox(
                                width: 25,
                                height: 25,
                                child: SvgPicture.asset(
                                  AssetsImages.chatMicSVG,
                                ),
                              ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
