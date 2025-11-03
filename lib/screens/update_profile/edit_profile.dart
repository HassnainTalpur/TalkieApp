import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  EditProfile({super.key});
  final RxBool isEditing = false.obs;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final ImageController imageController = Get.find<ImageController>();

    // 🛡 Defensive controller lookup — avoids crash if deleted mid-navigation
    final ProfileController profileController = Get.find<ProfileController>();

    final ContactController? contactController = Get.find<ContactController>();

    // 🧩 If controller got deleted while navigating, show loader instead of crashing
    if (profileController == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.offAllNamed('/home');
            },
          ),
        ),

        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
                                              : const AssetImage(
                                                  AssetsImages.uploadPic,
                                                ),
                                          backgroundColor: tBackgroundColor,
                                          radius: 80,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: tBackgroundColor,
                                        radius: 80,
                                        child:
                                            profileController
                                                    .currentUser
                                                    .value
                                                    .profileImage !=
                                                null
                                            ? ClipOval(
                                                child: Image.network(
                                                  profileController
                                                      .currentUser
                                                      .value
                                                      .profileImage!,
                                                  width: 160,
                                                  height: 160,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipOval(
                                                child: SvgPicture.asset(
                                                  AssetsImages.appIconSVG,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
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
                                    debugPrint(
                                      '✅ Profile updated: $newName, $newAbout',
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
