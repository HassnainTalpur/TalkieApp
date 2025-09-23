import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:talkie/models/user_model.dart';

class ContactController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  Future<void> getContacts() async {
    userList.clear();
    await db
        .collection('users')
        .get()
        .then(
          (value) => userList.value = value.docs
              .map((e) => UserModel.fromJson(e.data()))
              .toList(),
        );
  }
}
