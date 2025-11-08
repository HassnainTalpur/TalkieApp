import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class StatusService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();

  Future<void> trackingStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }

    final uid = user.uid;
    final userStatusRef = _db.child('status/$uid');
    final connectedRef = _db.child('.info/connected');

    connectedRef.onValue.listen((event) async {
      final connected = event.snapshot.value == true;

      if (connected) {
        await userStatusRef.onDisconnect().update({
          'state': 'offline',
          'last_changed': ServerValue.timestamp,
        });

        await userStatusRef.update({
          'state': 'online',
          'last_changed': ServerValue.timestamp,
        });
      }
    });
  }

  Future<void> stopTrackingPresence() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    await _db.child('status/$uid').update({
      'state': 'offline',
      'last_changed': ServerValue.timestamp,
    });
  }
}
