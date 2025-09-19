import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkie/screens/home_screen/widgets/chat_tile.dart';
import 'package:talkie/screens/search_screen/widgets/new_contact_tile.dart';
import 'package:talkie/screens/search_screen/widgets/search_contact.dart';
import 'package:talkie/utils/constants/images.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Rx<bool> searching = false.obs;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Select Contact'),
        actions: [
          IconButton(
            onPressed: () {
              searching.value = !searching.value;
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Obx(() => searching.value ? SearchContact() : SizedBox(height: 10)),
            NewContactTile(icon: Icons.person_add, text: 'New Contact'),
            NewContactTile(icon: Icons.group_add, text: 'New Group'),
            SizedBox(height: 10),
            Text('Contacts on Talkie'),
            SizedBox(height: 10),
            ChatTile(
              contactName: 'hasnain',
              lastChat: 'sned noods',
              delieveryTime: '10:30',
              imageUrl: AssetsImages.boyPic,
            ),
            ChatTile(
              contactName: 'hasnain',
              lastChat: 'sned noods',
              delieveryTime: '10:30',
              imageUrl: AssetsImages.boyPic,
            ),
            ChatTile(
              contactName: 'hasnain',
              lastChat: 'sned noods',
              delieveryTime: '10:30',
              imageUrl: AssetsImages.boyPic,
            ),
            ChatTile(
              contactName: 'hasnain',
              lastChat: 'sned noods',
              delieveryTime: '10:30',
              imageUrl: AssetsImages.boyPic,
            ),
          ],
        ),
      ),
    );
  }
}
