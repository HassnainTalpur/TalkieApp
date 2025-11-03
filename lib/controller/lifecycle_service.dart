import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AppLifecycleService extends GetxService with WidgetsBindingObserver {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  final _database = FirebaseFirestore.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    super.onInit();
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((token) async {
      if (token != null) {
        print('YOUR TOKENNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN ${token}');
        await _database.collection('users').doc(_auth.currentUser!.uid).update({
          'role': token,
        });
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final user = _auth.currentUser;
    if (user == null) return;

    final ref = _db.child('status/${user.uid}');

    if (state == AppLifecycleState.resumed) {
      ref.update({'state': 'online', 'last_changed': ServerValue.timestamp});
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      ref.update({'state': 'offline', 'last_changed': ServerValue.timestamp});
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
