import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'call_controller.dart';
import 'chat_controller.dart';
import 'contact_controller.dart';
import 'image_controller.dart';
import 'profile_controller.dart';
import 'status_controller.dart';
import 'status_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final presenceService = Get.put(StatusService(), permanent: true);

  Future<void> logIn(String email, String password) async {
    isLoading = true.obs;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print('⚡️ Logged in. Starting presence tracking...');

      // ✅ Recreate ProfileController for the new user
      if (!Get.isRegistered<ProfileController>()) {
        Get.put(ProfileController());
      }

      // Optionally reinit others if needed
      if (!Get.isRegistered<ChatController>()) {
        Get.lazyPut(() => ChatController(), fenix: true);
      }
      if (!Get.isRegistered<ContactController>()) {
        Get.lazyPut(() => ContactController(), fenix: true);
      }
      if (!Get.isRegistered<StatusController>()) {
        Get.lazyPut(() => StatusController(), fenix: true);
      }

      await presenceService.trackingStatus();
      print('✅ Presence tracking started');

      await Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print('AUTH CONTROLLER EXCEPTION  LOGIN !!!!!!!!!!!!! $e');
    }
    isLoading = false.obs;
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await inIt(email, name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('weak-password', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'email-already-in-use',
          'The account already exists for that email.',
        );
      }
    } catch (e) {
      print('AUTH CONTROLLER EXCEPTION SIGN UP !!!!!!!!!!!!! $e');
    }
  }

  Future<void> logOut() async {
    try {
      await presenceService.stopTrackingPresence();
      await auth.signOut();
      // Then navigate to auth screen
      // 🧹 Clear all user-specific controllers
      Get
        ..delete<ProfileController>(force: true)
        ..delete<ContactController>(force: true)
        ..delete<ChatController>(force: true)
        ..delete<StatusController>(force: true)
        ..delete<CallController>(force: true)
        ..delete<ImageController>(force: true)
        // 🌀 Recreate fresh instances (if you still need them globally)
        ..lazyPut(() => ChatController(), fenix: true)
        ..lazyPut(() => ContactController(), fenix: true)
        ..lazyPut(() => StatusController(), fenix: true)
        ..lazyPut(() => ImageController(), fenix: true)
        ..lazyPut(() => CallController(), fenix: true);
      await Get.offAllNamed('/auth');

      print('✅ Logged out, all GetX controllers cleared');
    } catch (e) {
      print('❌ Error logging out: $e');
      Get.snackbar('Error', 'Failed to log out. Please try again.');
    }
  }

  Future<void> inIt(String email, String name) async {
    try {
      final newUser = UserModel(
        email: email,
        name: name,
        id: auth.currentUser!.uid,
        createdAt: DateTime.now().toString(),
      );
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (e) {
      print('AUTH CONTROLLER EXCEPTION INIT !!!!!!!!!!!!! $e');
    }
  }
}
