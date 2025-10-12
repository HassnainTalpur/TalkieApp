import 'package:flutter/material.dart';

import '../../utils/widgets/welcome_heading.dart';
import 'widgets/welcome_page.dart';
import 'widgets/welcome_slider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [WelcomeHeading(), WelcomePage(), WelcomeSlider()],
          ),
        ),
      ),
    );
}
