import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({required this.tabController, super.key});
  final TabController tabController;
  @override
  Widget build(BuildContext context) => TabBar(
      controller: tabController,
      dividerColor: tBackgroundColor,
      unselectedLabelColor: tonContainerColor,
      enableFeedback: false,
      indicatorWeight: 3,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      tabs: const [Text('Chats'), Text('Groups'), Text('Calls')],
    );

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
