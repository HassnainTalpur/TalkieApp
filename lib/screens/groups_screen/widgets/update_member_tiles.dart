import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/groupchat_controller.dart';
import '../../../models/groupchat_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';
import '../../search_screen/widgets/display_pic.dart';

class UpdateMemberTiles extends StatelessWidget {
  UpdateMemberTiles({
    required this.about,
    required this.id,
    super.key,
    this.name,
    this.role,
    this.imageUrl,
    this.addContact = false,
    required this.groupModel,
  });
  final String? name;
  final String? about;
  final String? role;
  final String id;
  final String? imageUrl;
  bool addContact;
  final GroupChatRoomModel groupModel;
  final GroupchatController groupchatController = Get.put(
    GroupchatController(),
  );
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),

      // margin: EdgeInsets.all(3),
      child: Row(
        children: [
          DisplayPic(imageUrl: imageUrl),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? '', style: TText.bodyMedium),
                    Text(about ?? '', style: TText.labelMedium),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        groupchatController.kickMember(id, groupModel.id!);
                      },
                      child: const Text(
                        'Kick',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
