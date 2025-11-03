import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';
import 'controller/call_controller.dart';
import 'controller/chat_controller.dart';
import 'controller/contact_controller.dart';
import 'controller/groupchat_controller.dart';
import 'controller/image_controller.dart';
import 'controller/lifecycle_service.dart';
import 'controller/notifications_controller.dart';
import 'controller/permission_controller.dart';
import 'controller/profile_controller.dart';
import 'controller/splash_controller.dart';
import 'controller/status_controller.dart';
import 'controller/status_service.dart';
import 'firebase_options.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'utils/constants/paths.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppLifecycleService().initNotification();
  setupControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: pagePath,
    title: 'Talkie',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.dark,
    home: const SplashScreen(),
  );
}

void setupControllers() {
  Get
    ..put(AuthController())
    ..put(ProfileController(), permanent: true)
    ..lazyPut(() => ImageController(), fenix: true) // ⬅ register first
    ..lazyPut(() => GroupchatController(), fenix: true) // ✅ use lazyPut + fenix
    ..put(StatusService())
    ..put(AppLifecycleService())
    // Order of lazy controllers matters
    ..lazyPut(() => PermissionController(), fenix: true)
    ..lazyPut(
      () => ChatController(),
      fenix: true,
    ) // ⬅ depends on ImageController
    ..lazyPut(() => CallController(), fenix: true)
    ..lazyPut(() => ContactController(), fenix: true)
    ..lazyPut(() => SplashController(), fenix: true)
    ..lazyPut(() => StatusController(), fenix: true);
}
