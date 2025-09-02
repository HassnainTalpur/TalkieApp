import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      dividerColor: tBackgroundColor,
      unselectedLabelColor: tonContainerColor,
      enableFeedback: false,
      indicatorWeight: 3,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      tabs: [Text('Chats'), Text('Groups'), Text('Calls')],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
