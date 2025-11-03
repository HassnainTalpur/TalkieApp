class CallModel {
  String? id;
  String? callerId;
  String? receiverId;
  String? callerName;
  String? callerEmail;
  String? dp;
  String? type;
  String? roomId;
  String? status;
  String? time;

  CallModel({
    this.id,
    this.callerId,
    this.receiverId,
    this.callerName,
    this.callerEmail,
    this.dp,
    this.type,
    this.roomId,
    this.status,
    this.time,
  });

  CallModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] is String) {
      id = json['id'];
    }
    if (json['callerId'] is String) {
      callerId = json['callerId'];
    }
    if (json['time'] is String) {
      time = json['time'];
    }
    if (json['receiverId'] is String) {
      receiverId = json['receiverId'];
    }
    if (json['callerName'] is String) {
      callerName = json['callerName'];
    }
    if (json['callerEmail'] is String) {
      callerEmail = json['callerEmail'];
    }
    if (json['dp'] is String) {
      dp = json['dp'];
    }
    if (json['type'] is String) {
      type = json['type'];
    }
    if (json['roomId'] is String) {
      roomId = json['roomId'];
    }
    if (json['status'] is String) {
      status = json['status'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['callerId'] = callerId;
    data['receiverId'] = receiverId;
    data['callerName'] = callerName;
    data['callerEmail'] = callerEmail;
    data['dp'] = dp;
    data['type'] = type;
    data['roomId'] = roomId;
    data['status'] = status;
    return data;
  }
}
