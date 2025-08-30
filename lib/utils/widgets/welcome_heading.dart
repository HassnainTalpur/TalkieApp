import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SvgPicture.asset(AssetsImages.appIconSVG)],
        ),
        SizedBox(height: 20),
        Text(
          'Talkie',
          style: TText.headlineLarge.copyWith(color: Colors.amber),
        ),
      ],
    );
  }
}
