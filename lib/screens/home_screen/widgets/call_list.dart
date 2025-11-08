import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/call_controller.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/text.dart';
import '../../call_screen/videocall.dart';
import '../../call_screen/voicecall.dart';
import '../../search_screen/widgets/display_pic.dart';

class CallList extends StatelessWidget {
  CallList({super.key});
  final CallController callController = Get.find<CallController>();
  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: callController.getCallHistory(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData) {
        return const Center(child: Text('No Calls Yet'));
      }

      final calls = snapshot.data!;
      if (calls.isEmpty) {
        return const Center(child: Text('No Calls Yet'));
      }

      return ListView.builder(
        padding: EdgeInsets.zero,

        itemCount: calls.length,
        itemBuilder: (context, index) {
          final name = calls[index].callerName;
          final url = calls[index].dp;
          final type = calls[index].type;
          final recieverId = calls[index].receiverId;
          final time = DateTime.parse(calls[index].time!);

          final formattedTime = DateFormat(
            'yyyy-MM-dd - kk:mm',
          ).format(time).toString();
          return ListTile(
            leading: DisplayPic(imageUrl: url),
            title: Text(name ?? 'Unknown Caller', style: TText.bodyMedium),
            subtitle: recieverId == callController.auth.currentUser!.uid
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.call_received,
                        color: Colors.red,
                        size: 15,
                      ),
                      Text(formattedTime, style: TText.labelMedium),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.call_made_outlined,
                        color: Colors.green,
                        size: 15,
                      ),
                      Text(formattedTime, style: TText.labelMedium),
                    ],
                  ),
            trailing: type == 'audio'
                ? InkWell(
                    onTap: () {
                      callController.makeCall(recieverId!, type!, name!, url!);
                      Get.to(
                        VoiceCall(
                          targetUser: UserModel(
                            id: recieverId,
                            profileImage: url,
                            name: name,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.call, color: Colors.green),
                  )
                : InkWell(
                    onTap: () {
                      callController.makeCall(recieverId!, type!, name!, url!);
                      Get.to(
                        VideoCall(
                          targetUser: UserModel(
                            id: recieverId,
                            profileImage: url,
                            name: name,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.video_call, color: Colors.green),
                  ),
          );
        },
      );
    },
  );
}
