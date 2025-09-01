import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';
import 'package:talkie/utils/widgets/primary_button.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Full Name',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.contacts_sharp, color: tonContainerColor),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.alternate_email, color: tonContainerColor),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.password, color: tonContainerColor),
          ),
        ),
        SizedBox(height: 50),
        PrimaryButton(
          buttonIcon: Icons.lock_open_rounded,
          buttonText: 'SIGN IN',
        ),
      ],
    );
  }
}
