import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/controller/image_controller.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/widgets/primary_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    ProfileController profileController = Get.put(ProfileController());
    RxBool isEditing = false.obs;

    final TextEditingController nameController = TextEditingController(
      text: profileController.currentUser.value.name,
    );
    final TextEditingController aboutController = TextEditingController(
      text: 'YOUR BIO',
    );

    final ImageController imageController = Get.put(ImageController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: tContainerColor,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => isEditing.value
                                    ? InkWell(
                                        onTap: () {
                                          imageController.imagePicker(
                                            ImageSource.gallery,
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundImage:
                                              imageController.image.value !=
                                                  null
                                              ? FileImage(
                                                  imageController.image.value!,
                                                )
                                              : AssetImage(
                                                  AssetsImages.appIconSVG,
                                                ),
                                          backgroundColor: tBackgroundColor,
                                          radius: 80,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            imageController.image.value != null
                                            ? FileImage(
                                                imageController.image.value!,
                                              )
                                            : AssetImage(
                                                AssetsImages.appIconSVG,
                                              ),
                                        backgroundColor: tBackgroundColor,
                                        radius: 80,
                                      ),
                              ),
                            ),

                            Obx(() {
                              return TextFormField(
                                controller: profileController.nameController,
                                decoration: InputDecoration(
                                  filled: isEditing.value,
                                  enabled: isEditing.value,
                                  labelText: 'AHHHHH',
                                  prefixIcon: Icon(
                                    Icons.precision_manufacturing_outlined,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 10),
                            Obx(
                              () => TextField(
                                controller: aboutController,
                                decoration: InputDecoration(
                                  filled: isEditing.value,
                                  enabled: isEditing.value,
                                  labelText: 'About',
                                  prefixIcon: Icon(Icons.woo_commerce_outlined),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                filled: isEditing.value,
                                enabled: isEditing.value,
                                labelText: 'YOUREMAIL@.com',
                                hintText: 'EMail',
                                prefixIcon: Icon(Icons.woo_commerce_outlined),
                              ),
                            ),

                            SizedBox(height: 20),
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  isEditing.value = !isEditing.value;
                                  print(nameController);
                                },
                                child: isEditing.value
                                    ? PrimaryButton(
                                        buttonIcon: Icons.edit,
                                        buttonText: 'Save',
                                      )
                                    : PrimaryButton(
                                        buttonIcon: Icons.save,
                                        buttonText: 'Edit',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                authController.logOut();
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
