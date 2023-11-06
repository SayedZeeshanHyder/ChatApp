class ChatUser {
  String? image;
  String? about;
  String? name;
  String? createdAt;
  String? isOnline;
  String? lastActive;
  String? id;
  String? email;
  String? pushToken;

  ChatUser(
      {this.image,
        this.about,
        this.name,
        this.createdAt,
        this.isOnline,
        this.lastActive,
        this.id,
        this.email,
        this.pushToken});

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    about = json['about'];
    name = json['name'];
    createdAt = json['created_at'];
    isOnline = json['is_online'];
    lastActive = json['last_active'];
    id = json['id'];
    email = json['email'];
    pushToken = json['push_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['about'] = this.about;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['is_online'] = this.isOnline;
    data['last_active'] = this.lastActive;
    data['id'] = this.id;
    data['email'] = this.email;
    data['push_token'] = this.pushToken;
    return data;
  }
}