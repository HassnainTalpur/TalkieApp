class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.about,
    this.createdAt,
    this.lastOnlineStatus,
    this.status,
    this.role,
  });

  /// ✅ Updated fromJson ensures 'id' is always initialized.
  /// If 'id' is missing from Firestore data, it will be filled manually.
  factory UserModel.fromFirestore(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return UserModel(
      id: json['id'] ?? documentId, // ✅ ensure Firestore document ID is used
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      about: json['about'],
      createdAt: json['createdAt'],
      lastOnlineStatus: json['lastOnlineStatus'],
      status: json['status'],
      role: json['role'],
    );
  }

  /// Keep your original fromJson for non-Firestore sources (optional)
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    about = json['about'];
    createdAt = json['createdAt'];
    lastOnlineStatus = json['lastOnlineStatus'];
    status = json['status'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    data['about'] = about;
    data['createdAt'] = createdAt;
    data['lastOnlineStatus'] = lastOnlineStatus;
    data['status'] = status;
    data['role'] = role;
    return data;
  }
}
