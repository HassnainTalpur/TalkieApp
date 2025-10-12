import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthController authController = Get.put(AuthController());
    return Column(
      children: [
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
        authController.isLoading.value
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  authController.logIn(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: const PrimaryButton(
                  buttonIcon: Icons.lock_outlined,
                  buttonText: 'LOGIN',
                ),
              ),
      ],
    );
  }
}
