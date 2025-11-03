import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isBlank = false.obs;

  Rx<UserModel> currentUser = UserModel(name: '', about: '', email: '').obs;

  late TextEditingController nameController;
  late TextEditingController aboutController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: currentUser.value.name);
    print(nameController);
    isBlank = false.obs;
    aboutController = TextEditingController(text: currentUser.value.about);
    print(aboutController);
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    final user = auth.currentUser;
    if (user == null) return;

    try {
      final doc = await db.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        currentUser.value = UserModel.fromJson(data);
        nameController.text = currentUser.value.name ?? '';
        aboutController.text = currentUser.value.about ?? '';
      } else {
        debugPrint('⚠️ User document not found for ${user.uid}');
      }
    } catch (e) {
      debugPrint('❌ Error fetching user details: $e');
    }
  }

  Future<void> updateProfile(String name, String about) async {
    try {
      await db.collection('users').doc(auth.currentUser!.uid).update({
        'name': name,
        'about': about,
      });
      currentUser.update((user) {
        user?.name = name;
        user?.about = about;
      });
      debugPrint('✅ Profile updated successfully');
    } catch (e) {
      debugPrint('❌ Failed to update profile: $e');
      Get.snackbar('Error', 'Failed to update profile');
    }
  }
}
