import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/auth_controller.dart';
import '../../controller/contact_controller.dart';
import '../../controller/image_controller.dart';
import '../../controller/profile_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/widgets/primary_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    final ImageController imageController = Get.put(ImageController());
    final ProfileController profileController = Get.put(ProfileController());
    final ContactController contactController = Get.put(ContactController());
    final RxBool isEditing = false.obs;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(profileController.nameController);
        },
      ),
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
              child: DecoratedBox(
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
                                            : const AssetImage(
                                                AssetsImages.appIconSVG,
                                              ),
                                        backgroundColor: tBackgroundColor,
                                        radius: 80,
                                      ),
                              ),
                            ),

                            Obx(
                              () => TextFormField(
                                controller: profileController.nameController,
                                decoration: InputDecoration(
                                  filled: isEditing.value,
                                  enabled: isEditing.value,
                                  labelText: 'Name',
                                  prefixIcon: const Icon(
                                    Icons.precision_manufacturing_outlined,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => TextFormField(
                                controller: profileController.aboutController,
                                decoration: InputDecoration(
                                  filled: isEditing.value,
                                  enabled: isEditing.value,
                                  labelText: 'About',
                                  prefixIcon: const Icon(Icons.adobe_outlined),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                            Obx(
                              () => TextField(
                                decoration: InputDecoration(
                                  enabled: false,
                                  filled: false,
                                  labelText:
                                      profileController.currentUser.value.email,
                                  hintText: 'Email',
                                  prefixIcon: const Icon(
                                    Icons.woo_commerce_outlined,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            Obx(
                              () => InkWell(
                                onTap: () async {
                                  isEditing.value = !isEditing.value;
                                  await imageController.uploadProfileImage(
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
                                    print('!!!!!!!!!!!!!!!!! NAME CONTROLLER ');
                                    print(newAbout);
                                    print('!!!!!!!!!!!!!!!!! NAME CONTROLLER ');
                                    print(
                                      profileController
                                          .currentUser
                                          .value
                                          .profileImage,
                                    );
                                  }
                                },
                                child: isEditing.value
                                    ? const PrimaryButton(
                                        buttonIcon: Icons.edit,
                                        buttonText: 'Save',
                                      )
                                    : const PrimaryButton(
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
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
