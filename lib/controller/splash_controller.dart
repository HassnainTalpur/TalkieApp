import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splashHandler();
  }

  void splashHandler() async {
    await Future.delayed(const Duration(seconds: 3));
    if (auth.currentUser == null) {
      await Get.offAllNamed('/auth');
    } else {
      await Get.offAllNamed('/home');
    }
  }
}
