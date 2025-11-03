import 'chat_model.dart';
import 'user_model.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages;
  List<dynamic>? participants;
  int? unReadMessNo;
  int? toUnreadCount;
  String? lastMessage;
  String? lastMessageTimestamp;
  String? timestamp;
  ChatRoomModel({
    this.id,
    this.sender,
    this.receiver,
    this.messages,
    this.participants,
    this.unReadMessNo,
    this.toUnreadCount,

    this.lastMessage,
    this.lastMessageTimestamp,
    this.timestamp,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] is String) {
      id = json['id'];
    }
    if (json['sender'] is Map) {
      sender = json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender']);
    }
    if (json['receiver'] is Map) {
      receiver = json['receiver'] == null
          ? null
          : UserModel.fromJson(json['receiver']);
    }
    if (json['messages'] is List) {
      messages = json['messages'] ?? [];
    }
    if (json['participants'] is List) {
      participants = json['participants'] ?? [];
    }
    if (json['unReadMessNo'] is int) {
      unReadMessNo = json['unReadMessNo'];
    }
    if (json['toUnreadCount'] is int) {
      toUnreadCount = json['toUnreadCount'];
    }

    if (json['lastMessage'] is String) {
      lastMessage = json['lastMessage'];
    }
    if (json['lastMessageTimestamp'] is String) {
      lastMessageTimestamp = json['lastMessageTimestamp'];
    }
    if (json['timestamp'] is String) {
      timestamp = json['timestamp'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sender != null) {
      data['sender'] = sender?.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver?.toJson();
    }
    if (messages != null) {
      data['messages'] = messages;
    }
    if (participants != null) {
      data['participants'] = participants;
    }
    data['unReadMessNo'] = unReadMessNo;
    data['toUnreadCount'] = toUnreadCount;

    data['lastMessage'] = lastMessage;
    data['lastMessageTimestamp'] = lastMessageTimestamp;
    data['timestamp'] = timestamp;
    return data;
  }
}
