import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:slide_to_act/slide_to_act.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class WelcomeSlider extends StatelessWidget {
  const WelcomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () => Get.offAllNamed('/auth'),
      text: 'Slide to start now',
      textStyle: TText.labelLarge,
      sliderButtonIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(AssetsImages.plugSVG),
      ),
      innerColor: Colors.amber,
      outerColor: tContainerColor,
      submittedIcon: SvgPicture.asset(AssetsImages.plugSVG),
    );
  }
}
