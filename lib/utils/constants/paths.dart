import 'package:get/get.dart';
import 'package:talkie/screens/auth/auth_screen.dart';
import 'package:talkie/screens/chat/chat_screen.dart';
import 'package:talkie/screens/home_screen/home_screen.dart';
import 'package:talkie/screens/profile/profile_screen.dart';

var pagePath = [
  GetPage(
    name: '/auth',
    page: () => AuthScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/chat',
    page: () => ChatScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileScreen(),
    transition: Transition.rightToLeft,
  ),
];
