import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  void onInit() {
    super.onInit();
    splashHandler();
  }

  void splashHandler() async {
    await Future.delayed(Duration(seconds: 3));
    if (auth.currentUser == null) {
      Get.offAllNamed('/auth');
    } else {
      Get.offAllNamed('/home');
    }
  }
}
