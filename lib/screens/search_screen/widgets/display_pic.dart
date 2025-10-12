import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/images.dart';

class DisplayPic extends StatelessWidget {
  const DisplayPic({
    required this.imageUrl, super.key,
    this.assetImage = AssetsImages.boyPic,
    this.radius = 30,
  });
  final String? imageUrl;
  final String assetImage;
  final double radius;

  bool get isValidUrl => imageUrl != null && imageUrl!.trim().isNotEmpty;
  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: isValidUrl
            ? CachedNetworkImage(
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                imageUrl: imageUrl ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                    AssetsImages.boyPic,
                    fit: BoxFit.cover,
                    width: radius * 2,
                    height: radius * 2,
                  ),
              )
            : Image.asset(
                AssetsImages.boyPic,
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
              ),
      ),
    );
}
