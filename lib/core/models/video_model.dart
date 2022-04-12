import 'dart:convert';

import 'package:blindside/ui/constants/videos.dart';

class VideoModel {
  final int id;
  final String title;
  final String link;
  final String picture;
  final String quality;
  final List<Comment> comments;
  VideoModel({
    required this.id,
    required this.title,
    required this.link,
    required this.picture,
    required this.quality,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'picture': picture,
      'comments': sampleComments
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      link: map['link'] ?? '',
      picture: map['picture'] ?? '',
      quality: map["quality"] ?? '',
      comments: sampleComments.map((x) => Comment.fromMap(x)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source));
}

class Comment {
  final String name;
  final String comment;
  Comment({
    required this.name,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      name: map['name'] ?? '',
      comment: map['comment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}
