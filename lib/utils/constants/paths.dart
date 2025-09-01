import 'package:get/get.dart';
import 'package:talkie/screens/auth/auth_screen.dart';

var pagePath = [
  GetPage(
    name: '/auth',
    page: () => AuthScreen(),
    transition: Transition.rightToLeft,
  ),
];
