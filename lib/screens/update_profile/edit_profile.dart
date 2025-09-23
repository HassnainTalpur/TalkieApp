import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/controller/contact_controller.dart';
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

    final ImageController imageController = Get.put(ImageController());
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    RxBool isEditing = false.obs;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(contactController.userList);
        },
      ),
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
                                                  AssetsImages.uploadPic,
                                                ),
                                          backgroundColor: tBackgroundColor,
                                          radius: 80,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            profileController
                                                    .currentUser
                                                    .value
                                                    .profileImage !=
                                                null
                                            ? NetworkImage(
                                                profileController
                                                    .currentUser
                                                    .value
                                                    .profileImage!,
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
                                  labelText: 'Name',
                                  prefixIcon: Icon(
                                    Icons.precision_manufacturing_outlined,
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: 10),
                            Obx(() {
                              return TextFormField(
                                controller: profileController.aboutController,
                                decoration: InputDecoration(
                                  filled: isEditing.value,
                                  enabled: isEditing.value,
                                  labelText: 'About',
                                  prefixIcon: Icon(Icons.adobe_outlined),
                                ),
                              );
                            }),

                            SizedBox(height: 10),
                            Obx(
                              () => TextField(
                                decoration: InputDecoration(
                                  enabled: false,
                                  filled: false,
                                  labelText:
                                      profileController.currentUser.value.email,
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.woo_commerce_outlined),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            Obx(
                              () => InkWell(
                                onTap: () async {
                                  isEditing.value = !isEditing.value;
                                  await imageController.uploadImage(
                                    imageController.image,
                                    authController.auth.currentUser!.uid,
                                  );
                                  if (!isEditing.value) {
                                    imageController.image.value = null;
                                    final newName =
                                        profileController.nameController.text;
                                    final newAbout =
                                        profileController.aboutController.text;
                                    await profileController.updateProfile(
                                      newName,
                                      newAbout,
                                    );

                                    await profileController.getUserDetails();
                                    print("!!!!!!!!!!!!!!!!! NAME CONTROLLER ");
                                    print(newAbout);
                                    print("!!!!!!!!!!!!!!!!! NAME CONTROLLER ");
                                    print(
                                      profileController
                                          .currentUser
                                          .value
                                          .profileImage,
                                    );
                                  }
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
