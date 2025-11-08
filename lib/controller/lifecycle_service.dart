import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLifecycleService extends GetxService with WidgetsBindingObserver {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();
  final _firestore = FirebaseFirestore.instance;
  final _messaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    try {
      await _messaging.requestPermission();
      final token = await _messaging.getToken();
      final user = _auth.currentUser;

      if (user != null && token != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'notificationToken': token,
        }, SetOptions(merge: true));
      } else {
        debugPrint('⚠️ initNotification skipped: user or token is null');
      }
    } catch (e, st) {
      debugPrint('🔥 initNotification error: $e\n$st');
    }
  }

  Future<void> _updatePresence(AppLifecycleState state) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final ref = _db.child('status/${user.uid}');
    try {
      // Ensure disconnection cleanup is always queued
      await ref.onDisconnect().set({
        'state': 'offline',
        'last_changed': ServerValue.timestamp,
      });

      await ref.set({
        'state': state == AppLifecycleState.resumed ? 'online' : 'offline',
        'last_changed': ServerValue.timestamp,
      });
    } catch (e) {
      debugPrint('⚠️ Presence update failed: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    initNotification();
    _updatePresence(AppLifecycleState.resumed); // mark online at startup
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updatePresence(state);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
