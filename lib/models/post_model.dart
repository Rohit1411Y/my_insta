

import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final  datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const PostsModel(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profileImage,
      required this.likes});
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profileImage": profileImage,
        "likes": likes,
        "postUrl": postUrl,
      };

  static PostsModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostsModel(
        description: snap["description"],
        uid: snap["uid"],
        username: snap["username"],
        postId: snap["postId"],
        datePublished: snap["datePublished"],
        postUrl: snap["postUrl"],
        profileImage: snap["profileImage"],
        likes: snap["likes"]);
  }
}
