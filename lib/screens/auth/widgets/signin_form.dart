import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/connection_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../controller/profile_controller.dart';
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
    final AuthController authController = Get.find<AuthController>();
    final ProfileController profileController = Get.find<ProfileController>();

    final ConnectionController connectionController =
        Get.find<ConnectionController>();
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
            final bool isConnected =
                connectionController.isConnectedToInternet.value;
            if (isConnected) {
              await authController.signUp(
                emailController.text,
                passwordController.text,
                nameController.text,
              );
              await profileController.getUserDetails();

              if (FirebaseAuth.instance.currentUser != null) {
                await Get.toNamed('/home');
              }
            } else {
              Get.snackbar(
                'No Internet Connection',
                'Check your Internet Connection and Try again',
              );
            }
          },
          child: !authController.isLoading.value
              ? const PrimaryButton(
                  buttonIcon: Icons.lock_open_rounded,
                  buttonText: 'SIGN IN',
                )
              : const CircularProgressIndicator(),
        ),
      ],
    );
  }
}
