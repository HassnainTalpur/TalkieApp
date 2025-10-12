import 'group_participants.dart';

class GroupChatRoomModel {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? createdBy;
  String? createdAt;
  String? lastMessage;
  String? lastMessageSenderId;
  String? lastMessageTimestamp;

  List<String>? participantIds;
  // participants as a list of objects
  List<GroupParticipant>? participants;

  GroupChatRoomModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdBy,
    this.createdAt,
    this.lastMessage,
    this.lastMessageSenderId,
    this.lastMessageTimestamp,
    this.participants,
    this.participantIds,
  });

  GroupChatRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    lastMessage = json['lastMessage'];
    lastMessageSenderId = json['lastMessageSenderId'];
    lastMessageTimestamp = json['lastMessageTimestamp'];

    if (json['participantIds'] is List) {
      participantIds = json['participantIds'] == null
          ? null
          : List<String>.from(json['participantIds']);
    }

    if (json['participants'] is List) {
      participants = (json['participants'] as List)
          .map((e) => GroupParticipant.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (createdBy != null) {
      data['createdBy'] = createdBy;
    }
    data['createdAt'] = createdAt;
    data['lastMessage'] = lastMessage;
    data['lastMessageSenderId'] = lastMessageSenderId;
    data['lastMessageTimestamp'] = lastMessageTimestamp;
    if (participants != null) {
      data['participants'] = participants?.map((e) => e.toJson()).toList();
    }
    if (participantIds != null) {
      data['participantIds'] = participantIds;
    }
    return data;
  }
}
