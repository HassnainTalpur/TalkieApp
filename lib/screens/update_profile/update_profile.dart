import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/contact_controller.dart';
import '../../controller/groupchat_controller.dart';
import '../../controller/image_controller.dart';
import '../../controller/profile_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/text.dart';
import '../../utils/widgets/primary_button.dart';

class UpdateGroup extends StatelessWidget {
  UpdateGroup({super.key});
  final GroupchatController groupchatController =
      Get.find<GroupchatController>();
  final TextEditingController groupNameController = TextEditingController();
  final ContactController contactController = Get.find<ContactController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ImageController imageController = Get.find<ImageController>();
  RxBool isEditing = false.obs;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Get.offAllNamed('/home');
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      title: const Text('Group Details'),
      titleTextStyle: TText.bodyLarge,
    ),
    body: Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: tContainerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              imageController.imagePicker(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  imageController.image.value != null
                                  ? FileImage(imageController.image.value!)
                                  : const AssetImage(AssetsImages.uploadPic),
                              backgroundColor: tBackgroundColor,
                              radius: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Group Info', style: TText.bodyMedium),
                        const SizedBox(height: 10),

                        const SizedBox(height: 5),
                        TextField(
                          controller: groupNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: 'Group Name',
                            hintStyle: TText.labelMedium,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text('Group Members', style: TText.labelMedium),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Wrap(
                            spacing: 2, // horizontal space between items
                            runSpacing: 2, // vertical space between lines

                            children: groupchatController.selectedContacts
                                .map(
                                  (e) => Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: tBackgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                groupchatController.createGroupChat(
                                  groupNameController.text,
                                );
                                Get.offAllNamed('/home');
                              },
                              child: const PrimaryButton(
                                buttonIcon: Icons.save,
                                buttonText: 'Save',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
