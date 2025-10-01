import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class ImageController extends GetxController {
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  var isUploading = false.obs;
  var uploadedProfileUrl = "".obs;
  var uploadedImageUrl = "".obs;

  final String cloudName = "dgz8rnf5y"; // from Cloudinary dashboard dgz8rnf5y
  final String uploadPreset =
      "flutter_upload"; // the unsigned preset you created

  Future<void> imagePicker(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    try {
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> uploadImage(Rx<File?> image, String userId) async {
    isUploading.value = false;
    if (image.value == null) return null;

    final String uploadUrl =
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(image.value!.path),
        'upload_preset': uploadPreset,
      });

      dio.Response response = await dio.Dio().post(uploadUrl, data: formData);
      if (response.statusCode == 200) {
        uploadedImageUrl.value = response.data["secure_url"];

        return uploadedImageUrl.value;
      }
    } catch (e) {
      Get.snackbar("Error", "Upload failed: $e");
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> uploadProfileImage(Rx<File?> image, String userId) async {
    if (image.value == null) return;

    final String uploadUrl =
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(image.value!.path),
        'upload_preset': uploadPreset,
      });

      dio.Response response = await dio.Dio().post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        uploadedProfileUrl.value = response.data["secure_url"];

        await FirebaseFirestore.instance.collection('users').doc(userId).update(
          {"profileImage": uploadedProfileUrl.value},
        );
        Get.snackbar("Success", "Image Uploaded Successfully!");
      }
    } catch (e) {
      Get.snackbar("Error", "Upload failed: $e");
    } finally {
      isUploading.value = false;
    }
  }
}
