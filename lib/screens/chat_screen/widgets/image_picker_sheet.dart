import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/image_controller.dart';
import '../../../utils/constants/colors.dart';

Future<void> ImagePickerSheet(ImageController imageController) async {
  await Get.bottomSheet(
    Container(
      height: 150,
      decoration: const BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: tBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 70,
            height: 70,
            child: IconButton(
              onPressed: () {
                imageController.imagePicker(ImageSource.camera);
                Get.back();
              },
              icon: const Icon(Icons.camera, size: 30),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: tBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 70,
            height: 70,
            child: IconButton(
              onPressed: () {
                imageController.imagePicker(ImageSource.gallery);
                Get.back();
              },
              icon: const Icon(Icons.photo, size: 30),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: tBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 70,
            height: 70,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.video_camera_back, size: 30),
            ),
          ),
        ],
      ),
    ),
  );
}
