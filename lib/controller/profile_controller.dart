import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:talkie/models/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  Rx<UserModel> currentUser = UserModel().obs;
  late TextEditingController nameController;
  late TextEditingController aboutController;

  @override
  void onInit() async {
    super.onInit();
    nameController = TextEditingController();
    aboutController = TextEditingController();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then(
          (value) => {currentUser.value = UserModel.fromJson(value.data()!)},
        );

    nameController.text = currentUser.value.name ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    print("!!!!!!!!!!!!!!!!! his ahh got disposed");
    super.onClose();
  }

  void imagePicker() {}
}
