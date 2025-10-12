import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'utils/constants/paths.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
