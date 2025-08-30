import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsImages.boyPic),
            SvgPicture.asset('assets/Icons/connect.svg'),
            Image.asset(AssetsImages.girlPic),
          ],
        ),
        SizedBox(height: 20),
        Text('Now You Are', style: TText.headlineMedium),
        Text(
          'Connected',
          style: TText.headlineMedium.copyWith(color: Colors.amber),
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          'Perfect solution of connecting with anyone \n easily and more secure',
          style: TText.labelMedium,
        ),
      ],
    );
  }
}
