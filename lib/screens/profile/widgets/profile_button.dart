import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkie/utils/constants/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    this.color = Colors.blue,
  });
  final Color color;
  final String buttonText;
  final String buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            width: 25,
            buttonIcon,
            colorFilter: ColorFilter.mode(color, BlendMode.modulate),
          ),
          SizedBox(width: 10),
          Text(buttonText, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
