import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.buttonIcon, required this.buttonText, super.key,
  });
  final IconData buttonIcon;
  final String buttonText;
  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: tPrimaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(buttonIcon),
              const SizedBox(width: 10),
              Text(buttonText, style: TText.bodyLarge),
            ],
          ),
        ),
      ],
    );
}
