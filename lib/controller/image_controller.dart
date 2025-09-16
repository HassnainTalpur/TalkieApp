import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

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
}
