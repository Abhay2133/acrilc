class UserData {
  final String? id;
  final String? username;
  final String? fullName;
  final String? email;
  final String? profilePicture;
  final String? bio;
  final String? story;
  final Map<String, dynamic>? socialLinks;
  final String? visibility;
  final List<String>? followers;
  final List<String>? following;
  final String? role;
  final List<String>? preferences;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserData({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.profilePicture,
    this.bio,
    this.story,
    this.socialLinks,
    this.visibility,
    this.followers,
    this.following,
    this.role,
    this.preferences,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? "",
      username: json['username'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      profilePicture: json['profilePicture'] ?? "",
      bio: json['bio'] ?? "",
      story: json['story'] ?? "",
      socialLinks: Map<String, dynamic>.from(json['socialLinks'] ?? {}),
      visibility: json['visibility'] ?? "",
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      role: json['role'] ?? "",
      preferences: List<String>.from(json['preferences'] ?? []),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'profilePicture': profilePicture,
      'bio': bio,
      'story': story,
      'socialLinks': socialLinks,
      'visibility': visibility,
      'followers': followers,
      'following': following,
      'role': role,
      'preferences': preferences,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
