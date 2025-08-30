import 'package:flutter/material.dart';
import 'package:talkie/utils/widgets/welcome_heading.dart';
import 'package:talkie/utils/widgets/welcome_page.dart';
import 'package:talkie/utils/widgets/welcome_slider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [WelcomeHeading(), WelcomePage(), WelcomeSlider()],
          ),
        ),
      ),
    );
  }
}
