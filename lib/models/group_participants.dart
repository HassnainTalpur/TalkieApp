class GroupParticipant {
  String? userId;
  String? role; // "admin", "member"
  String? joinedAt;
  String? name;
  String? imageUrl;
  String? about;
  GroupParticipant({
    this.userId,
    this.role,
    this.joinedAt,
    this.about,
    this.name,
    this.imageUrl,
  });

  GroupParticipant.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    about = json['about'];
    role = json['role'];
    joinedAt = json['joinedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['about'] = about;
    data['role'] = role;
    data['joinedAt'] = joinedAt;
    return data;
  }
}
