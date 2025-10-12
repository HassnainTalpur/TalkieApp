import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/images.dart';
import '../constants/text.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SvgPicture.asset(AssetsImages.appIconSVG)],
        ),
        const SizedBox(height: 20),
        Text(
          'Talkie',
          style: TText.headlineLarge.copyWith(color: Colors.amber),
        ),
      ],
    );
}
