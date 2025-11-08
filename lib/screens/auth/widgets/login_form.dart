import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/connection_controller.dart';
import '../../../controller/image_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
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
                  final bool isConnected =
                      connectionController.isConnectedToInternet.value;
                  if (isConnected) {
                    authController.logIn(
                      emailController.text,
                      passwordController.text,
                    );
                    profileController.getUserDetails();
                  } else {
                    Get.snackbar(
                      'No Internet Connection',
                      'Check your Internet Connection and Try again',
                    );
                  }
                },
                child: !authController.isLoading.value
                    ? const PrimaryButton(
                        buttonIcon: Icons.lock_outlined,
                        buttonText: 'LOGIN',
                      )
                    : const CircularProgressIndicator(),
              ),
      ],
    );
  }
}
