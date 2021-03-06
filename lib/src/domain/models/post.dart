import 'package:flutter/material.dart';

class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return (other is Post) &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.userId == userId;
  }

  @override
  int get hashCode => hashValues(id, title, body, userId);
}
