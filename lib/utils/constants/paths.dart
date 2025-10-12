import 'package:get/get.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/search_screen/search_screen.dart';
import '../../screens/update_profile/edit_profile.dart';
import '../../screens/update_profile/update_profile.dart';

var pagePath = [
  GetPage(
    name: '/auth',
    page: () => const AuthScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    transition: Transition.rightToLeft,
  ),

  GetPage(
    name: '/updateprofile',
    page: () => UpdateGroup(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/editprofile',
    page: () => const EditProfile(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/search',
    page: () => const SearchScreen(),
    transition: Transition.leftToRight,
  ),
];
