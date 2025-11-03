import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/call_controller.dart';
import '../../controller/permission_controller.dart';
import '../../controller/profile_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/text.dart';
import 'widgets/call_list.dart';
import 'widgets/chat_list.dart';
import 'widgets/group_list.dart';
import 'widgets/tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 3, vsync: this);
    final CallController callController = Get.find<CallController>();
    final ProfileController profileController = Get.find<ProfileController>();
    final PermissionController permissionController =
        Get.find<PermissionController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed('/search');
        },
        backgroundColor: tPrimaryColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(AssetsImages.appIconSVG),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        title: const Text('Talkie'),
        titleTextStyle: TText.headlineSmall.copyWith(color: Colors.white),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Get.offAllNamed('/editprofile');
            },
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
        bottom: MyTabBar(tabController: tabController),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: tabController,
          children: [
            ChatList(), // Tab 1
            GroupList(), // Tab 2 placeholder
            CallList(), // Tab 3 placeholder
          ],
        ),
      ),
    );
  }
}
