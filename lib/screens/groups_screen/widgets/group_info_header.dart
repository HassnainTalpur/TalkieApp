import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../search_screen/widgets/display_pic.dart';

class GroupInfoHeader extends StatelessWidget {
  const GroupInfoHeader({
    required this.name,

    required this.imageUrl,
    super.key,
  });
  final String name;

  final String imageUrl;
  @override
  Widget build(BuildContext context) => Container(
    //height: 300,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: tContainerColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [DisplayPic(imageUrl: imageUrl, radius: 50)],
              ),
              const SizedBox(height: 10),
              Text(name, style: TText.bodyMedium),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    ),
  );
}
