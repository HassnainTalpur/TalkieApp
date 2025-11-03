import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final RxString status = 'offline'.obs;
  final Rx<DateTime?> lastChanged = Rx<DateTime?>(null);

  DatabaseReference? _ref;

  void listenToUser(String uid) {
    _ref = FirebaseDatabase.instance.ref('status/$uid');
    _ref!.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        status.value = data['state'] ?? 'offline';
        final ts = data['last_changed'];
        if (ts != null) {
          lastChanged.value = DateTime.fromMillisecondsSinceEpoch(ts);
        }
      } else {
        status.value = 'offline';
        lastChanged.value = null;
      }
    });
  }

  @override
  void onClose() {
    _ref?.onDisconnect();
    super.onClose();
  }
}
