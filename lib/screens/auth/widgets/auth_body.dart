import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:talkie/screens/auth/widgets/login_form.dart';
import 'package:talkie/screens/auth/widgets/signin_form.dart';

import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = false.obs;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            isLogin.value = true;
                          },
                          child: Column(
                            children: [
                              Text(
                                'Login',
                                style: isLogin.value
                                    ? TText.bodyLarge
                                    : TText.labelSmall,
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: isLogin.value ? 100 : 0,
                                height: 3,
                                color: tPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            isLogin.value = false;
                          },

                          child: Column(
                            children: [
                              Text(
                                'Signup',
                                style: isLogin.value
                                    ? TText.labelSmall
                                    : TText.bodyLarge,
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: isLogin.value ? 0 : 100,
                                height: 3,
                                color: tPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => isLogin.value ? LoginForm() : SigninForm()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
