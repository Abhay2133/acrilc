import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String profilePicture;
  final String bio;
  final String story;
  final Map<String, String> socialLinks;
  final String visibility;
  final List<String> followers;
  final List<String> following;
  final List<String> preferences;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.story,
    required this.socialLinks,
    required this.visibility,
    required this.followers,
    required this.following,
    required this.preferences,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
      story: json['story'],
      socialLinks: Map<String, String>.from(json['socialLinks']),
      visibility: json['visibility'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
      preferences: List<String>.from(json['preferences']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      'preferences': preferences,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  void setUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  void updateUser(Map<String, dynamic> newUserData) {
    if (_user != null) {
      _user = UserModel.fromJson({..._user!.toJson(), ...newUserData});
      notifyListeners();
    }
  }
}
