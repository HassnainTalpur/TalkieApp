import 'package:flutter/material.dart';

import '../../utils/widgets/welcome_heading.dart';
import 'widgets/auth_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
