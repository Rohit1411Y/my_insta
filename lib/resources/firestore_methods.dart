import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_insta/models/post_model.dart';
import 'package:my_insta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
      String description, Uint8List file, String uid,
      String username,
      String profileImage
      ) async {
       
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const  Uuid().v1();    
      PostsModel postsModel = PostsModel(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl:photoUrl,
          profileImage: profileImage,
          likes: []);

          await _firestore.collection('posts').doc(postId).set(postsModel.toJson());
          res = "success";
    } catch (err) {
      return err.toString();
    }

    return res;
  }
}
