import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/models/user_model.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> logIn(String email, String password) async {
    isLoading = true.obs;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("AUTH CONTROLLER EXCEPTION  LOGIN !!!!!!!!!!!!! ${e}");
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
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("AUTH CONTROLLER EXCEPTION SIGN UP !!!!!!!!!!!!! ${e}");
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
    Get.offAllNamed('/auth');
  }

  Future<void> inIt(String email, String name) async {
    try {
      var newUser = UserModel(
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
      print("AUTH CONTROLLER EXCEPTION INIT !!!!!!!!!!!!! ${e}");
    }
  }
}
