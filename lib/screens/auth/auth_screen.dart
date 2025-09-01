import 'package:flutter/material.dart';
import 'package:talkie/screens/auth/widgets/auth_body.dart';
import 'package:talkie/utils/widgets/welcome_heading.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                WelcomeHeading(),
                SizedBox(height: 50),
                AuthBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
