import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkie/screens/home_screen/widgets/tab_bar.dart';
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
    final TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(AssetsImages.appIconSVG),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        title: Text('TALKIE'),
        titleTextStyle: TText.headlineSmall.copyWith(color: Colors.white),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
        bottom: MyTabBar(tabController: tabController),
      ),
    );
  }
}
