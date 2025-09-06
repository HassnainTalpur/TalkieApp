import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkie/screens/chat/widgets/chat_bubble.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/images.dart';
import 'package:talkie/utils/constants/text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mir', style: TText.bodyLarge),
            Text('online', style: TText.labelMedium),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: tContainerColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(AssetsImages.chatMicSVG),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Type message ....',
                  hintStyle: TText.labelLarge,
                ),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(AssetsImages.chatGallerySVG),
            ),
            SizedBox(width: 10),
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(AssetsImages.chatSendSVG),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChatBubble(
                isComing: true,
                message: 'Yeh Mera Dil pyaar ka dewaana ',
                time: '10:12 am',
                imageUrl: '',
                status: 'Read',
              ),
              SizedBox(height: 10),
              ChatBubble(
                isComing: false,
                message: 'Yeh Mera Dil pyaar ka dewaana ',
                time: '10:12 am',
                imageUrl: '',
                status: 'Read',
              ),
              ChatBubble(
                isComing: false,
                message: 'lawday',
                time: '10:12 am',
                imageUrl:
                    'https://camo.githubusercontent.com/157f305a6fc1cb412068fdaaa21a5c27964fd0d8a9735a9a6adaca6888f5f9b8/68747470733a2f2f626c6f676765722e676f6f676c6575736572636f6e74656e742e636f6d2f696d672f622f523239765a32786c2f41567658734567306453786c5f494b7951535a432d4c6c4f2d533070744768734651784b6f7678766e3743686b7863516661584c6d6969613668516d4c6a6d57744849633457533636532d754f38706d5f4a474c423544544d67494f7159453279554578444f345a5031306376754136765833556d5935544a374673712d6564346d766366794f6269384d5a716b4d5952492d38774f69657357363458635738724c72663558764b6b68466b6d4e353837696157563434454b79383452556b48576456652f73313934372f636861746461726b2e706e67',
                status: 'Read',
              ),
              SizedBox(height: 10),
              ChatBubble(
                isComing: true,
                message: 'Yeh Mera Dil pyaar ka dewaana ',
                time: '10:12 am',
                imageUrl: '',
                status: 'Read',
              ),
              ChatBubble(
                isComing: true,
                message: 'lawday',
                time: '10:12 am',
                imageUrl:
                    'https://camo.githubusercontent.com/157f305a6fc1cb412068fdaaa21a5c27964fd0d8a9735a9a6adaca6888f5f9b8/68747470733a2f2f626c6f676765722e676f6f676c6575736572636f6e74656e742e636f6d2f696d672f622f523239765a32786c2f41567658734567306453786c5f494b7951535a432d4c6c4f2d533070744768734651784b6f7678766e3743686b7863516661584c6d6969613668516d4c6a6d57744849633457533636532d754f38706d5f4a474c423544544d67494f7159453279554578444f345a5031306376754136765833556d5935544a374673712d6564346d766366794f6269384d5a716b4d5952492d38774f69657357363458635738724c72663558764b6b68466b6d4e353837696157563434454b79383452556b48576456652f73313934372f636861746461726b2e706e67',
                status: 'Read',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
