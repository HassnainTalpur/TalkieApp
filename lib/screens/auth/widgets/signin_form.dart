import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/widgets/primary_button.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthController authController = AuthController();
    return Column(
      children: [
        const SizedBox(height: 20),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Full Name',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.contacts_sharp, color: tonContainerColor),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.alternate_email, color: tonContainerColor),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            hintText: 'Password',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.password, color: tonContainerColor),
          ),
        ),
        const SizedBox(height: 50),
        InkWell(
          onTap: () async {
            await authController.signUp(
              emailController.text,
              passwordController.text,
              nameController.text,
            );
            if (FirebaseAuth.instance.currentUser != null) {
              Get.offAllNamed('/home');
            }
          },
          child: const PrimaryButton(
            buttonIcon: Icons.lock_open_rounded,
            buttonText: 'SIGN IN',
          ),
        ),
      ],
    );
  }
}
