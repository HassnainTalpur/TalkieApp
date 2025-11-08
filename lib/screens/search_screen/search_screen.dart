import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/chat_controller.dart';
import '../../controller/contact_controller.dart';
import '../chat_screen/chat.dart';
import '../groups_screen/create_group.dart';
import '../home_screen/widgets/chat_tile.dart';
import 'widgets/new_contact_tile.dart';
import 'widgets/search_contact.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Rx<bool> searching = false.obs;
    final ChatController chatController = Get.find<ChatController>();
    final ContactController contactController = Get.find<ContactController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.toNamed('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.toNamed('/home');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Select Contact'),
          actions: [
            IconButton(
              onPressed: () {
                searching.value = !searching.value;
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Obx(
                () => searching.value
                    ? const SearchContact()
                    : const SizedBox(height: 10),
              ),
              const NewContactTile(icon: Icons.person_add, text: 'New Contact'),
              InkWell(
                onTap: () {
                  Get.to(() => CreateGroup());
                },
                child: const NewContactTile(
                  icon: Icons.group_add,
                  text: 'New Group',
                ),
              ),
              const SizedBox(height: 10),
              const Text('Contacts on Talkie'),
              const SizedBox(height: 10),

              Obx(
                () => Column(
                  children: contactController.userList
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Get.to(() => ChatScreen(userModel: e));
                          },
                          child: ChatTile(
                            unReadCount: 0,
                            contactName: e.name ?? '',
                            lastChat: e.about ?? '',

                            delieveryTime:
                                e.email ==
                                    chatController.auth.currentUser!.email
                                ? 'You'
                                : '10:00',
                            imageUrl: e.profileImage ?? '',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
