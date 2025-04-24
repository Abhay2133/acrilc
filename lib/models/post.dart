
/// Data model for post upload
class PostUploadData {
  final String title;
  final String? subtitle;
  final String story;
  final String size;
  final List<String>? links;
  final List<String> hashTags;
  final List<String>? mentions;
  final String? location;
  final String forte;
  final String? collectionId;
  final List<String> files;

  PostUploadData({
    required this.title,
    required this.hashTags,
    required this.story,
    required this.size,
    required this.forte,
    required this.files,
    this.subtitle,
    this.links,
    this.mentions,
    this.location,
    this.collectionId,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "story": story,
    "size": size,
    "links": links,
    "hashTags": hashTags,
    "mentions": mentions,
    "location": location,
    "forte": forte,
    "collectionId": collectionId,
    "files": files,
  };

  Map<String, String> normalize() => {
    "title": title,
    "subtitle": subtitle ?? "",
    "story": story,
    "size": size,
    "links": (links ?? []).join(","),
    "hashTags": (hashTags).join(","),
    "mentions": (mentions ?? []).join(","),
    "location": location ?? "",
    "forte": forte,
    "collectionId": collectionId ?? "",
  };
}

/// Data model for post response
class PostData {
  final String? id;
  final String? author;
  final String? title;
  final String? subtitle;
  final String? story;
  final String? size;
  final List<String>? links;
  final List<String>? hashTags;
  final List<String>? mentions;
  final List<dynamic>? media;
  final String? forte;
  final String? location;
  final List<dynamic>? applauds;
  final List<dynamic>? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PostData({
    this.id,
    this.author,
    this.title,
    this.subtitle,
    this.story,
    this.size,
    this.links,
    this.hashTags,
    this.mentions,
    this.media,
    this.forte,
    this.location,
    this.applauds,
    this.comments,
    this.createdAt,
    this.updatedAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['_id'],
      author: json['author'],
      title: json['title'],
      subtitle: json['subtitle'] ?? "",
      story: json['story'],
      size: json['size'],
      links: List<String>.from(json['links']),
      hashTags: List<String>.from(json['hashTags']),//.isNotEmpty ? List<String>.from(json['hashTags']?.first?.split(',')): List.empty(), // flatten
      mentions: List<String>.from(json['mentions']),
      media: List<dynamic>.from(json['media']),
      forte: json['forte'],
      location: json['location'],
      applauds: List<dynamic>.from(json['applauds']),
      comments: List<dynamic>.from(json['comments']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
