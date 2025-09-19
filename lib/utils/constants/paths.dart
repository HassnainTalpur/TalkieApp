import 'package:get/get.dart';
import 'package:talkie/screens/auth/auth_screen.dart';
import 'package:talkie/screens/chat/chat_screen.dart';
import 'package:talkie/screens/home_screen/home_screen.dart';
import 'package:talkie/screens/search_screen/search_screen.dart';
import 'package:talkie/screens/update_profile/edit_profile.dart';
import 'package:talkie/screens/user_profile/profile_screen.dart';
import 'package:talkie/screens/update_profile/update_profile.dart';

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
  GetPage(
    name: '/updateprofile',
    page: () => UpdateProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/editprofile',
    page: () => EditProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/search',
    page: () => SearchScreen(),
    transition: Transition.leftToRight,
  ),
];
