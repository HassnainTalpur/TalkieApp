import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/auth_controller.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';
import 'package:talkie/utils/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        SizedBox(height: 20),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.alternate_email, color: tonContainerColor),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TText.labelLarge,
            prefixIcon: Icon(Icons.password, color: tonContainerColor),
          ),
        ),
        SizedBox(height: 50),
        authController.isLoading.value
            ? CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  authController.logIn(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: PrimaryButton(
                  buttonIcon: Icons.lock_outlined,
                  buttonText: 'LOGIN',
                ),
              ),
      ],
    );
  }
}
