import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonIcon,
    required this.buttonText,
  });
  final IconData buttonIcon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: tPrimaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(buttonIcon),
              SizedBox(width: 10),
              Text(buttonText, style: TText.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
