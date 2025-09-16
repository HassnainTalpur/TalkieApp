import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';
import 'package:talkie/utils/widgets/primary_button.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Update Profile'),
        titleTextStyle: TText.bodyLarge,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: tContainerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            child: Icon(Icons.photo, size: 30),
                            radius: 100,
                            backgroundColor: tBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Personal Info', style: TText.labelMedium),
                          SizedBox(height: 10),

                          Text('Name', style: TText.bodyMedium),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              hintText: 'Mir Hasnain Hyder',
                              hintStyle: TText.labelMedium,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text('Email'),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Example@gmail.com',
                              hintStyle: TText.labelMedium,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text('Phone'),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.call),
                              hintText: '+92 xxxxxxxxxx',
                              hintStyle: TText.labelMedium,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                buttonIcon: Icons.save,
                                buttonText: 'Save',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
