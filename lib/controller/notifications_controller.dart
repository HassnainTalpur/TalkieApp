import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    super.onInit();
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
  }
}
