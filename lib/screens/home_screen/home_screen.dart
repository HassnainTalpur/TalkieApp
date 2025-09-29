import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:talkie/controller/profile_controller.dart';
import 'package:talkie/screens/home_screen/widgets/chat_list.dart';
import 'package:talkie/screens/home_screen/widgets/tab_bar.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed('/search');
        },
        backgroundColor: tPrimaryColor,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(AssetsImages.appIconSVG),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        title: Text('Talkie'),
        titleTextStyle: TText.headlineSmall.copyWith(color: Colors.white),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Get.offAllNamed('/editprofile');
            },
            icon: Icon(Icons.more_vert_outlined),
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
            Center(child: Text("Status")), // Tab 2 placeholder
            Center(child: Text("Calls")), // Tab 3 placeholder
          ],
        ),
      ),
    );
  }
}
