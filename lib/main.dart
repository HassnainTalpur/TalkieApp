import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:talkie/firebase_options.dart';
import 'package:talkie/screens/splash_screen/splash_screen.dart';
import 'package:talkie/screens/update_profile/edit_profile.dart';
import 'package:talkie/utils/constants/paths.dart';
import 'package:talkie/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pagePath,
      title: 'Talkie',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: EditProfile(),
    );
  }
}
