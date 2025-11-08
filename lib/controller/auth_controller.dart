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
      // ✅ Recreate ProfileController for the new user
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

      if (!Get.isRegistered<ImageController>()) {
        Get.lazyPut(() => ImageController(), fenix: true);
      }

      await presenceService.trackingStatus();
      // ✅ Initialize before navigating
      if (!Get.isRegistered<ProfileController>()) {
        Get.put(ProfileController(), permanent: true);
      } else {
        // refresh user data if controller already exists
        await Get.find<ProfileController>().getUserDetails();
      }

      await Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        default:
          errorMessage = 'An unknown error occurred: ${e.message}';
      }
      Get.snackbar('Error', errorMessage);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
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

      if (!Get.isRegistered<ProfileController>()) {
        Get.put(ProfileController());
      }
      if (!Get.isRegistered<ImageController>()) {
        Get.lazyPut(() => ImageController(), fenix: true);
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
      Get.snackbar('Error', 'Failed to Log In. Please try again.');
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
        ..delete<ImageController>(force: true);
      // 🌀 Recreate fresh instances (if you still need them globally)
      await Get.offAllNamed('/auth');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code);
    } catch (e) {
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
      Get.snackbar('Error', e.toString());
    }
  }
}
