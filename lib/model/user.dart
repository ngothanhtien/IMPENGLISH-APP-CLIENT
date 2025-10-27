class User {
  String? id;
  String? email;
  String? fullName;
  String? phone;
  String? avatar;
  int? streakDay;
  String? level;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? provider;
  String? googleId;
  bool? verify;
  bool? status;

  User({
    this.id,
    this.email,
    this.fullName,
    this.phone,
    this.avatar,
    this.streakDay,
    this.level,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.provider,
    this.googleId,
    this.verify,
    this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    avatar = json['avatar'];
    streakDay = json['streakDay'];
    level = json['level'];
    type = json['type'];
    provider = json['provider'];
    googleId = json['googleId'];
    verify = json['verify'];
    status = json['status'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['email'] = email;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['streakDay'] = streakDay;
    data['level'] = level;
    data['type'] = type;
    data['provider'] = provider;
    data['googleId'] = googleId;
    data['verify'] = verify;
    data['status'] = status;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}
