import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/images.dart';

class DisplayPic extends StatelessWidget {
  const DisplayPic({
    super.key,
    required this.imageUrl,
    this.assetImage = AssetsImages.boyPic,
    this.radius = 30,
  });
  final String? imageUrl;
  final String assetImage;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageUrl != ''
          ? NetworkImage(imageUrl!)
          : AssetImage(assetImage),
      radius: radius,
    );
  }
}
