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

  Future<void> likePost(String postId,String uid,List likes)async {
  try{
    if(likes.contains(uid)){
     await _firestore.collection('posts').doc(postId).update({
      'likes':FieldValue.arrayRemove([uid]),
     });
    }
    else{
      await _firestore.collection('posts').doc(postId).update({
       'likes':FieldValue.arrayUnion([uid]),
      });
    }
  }
  catch(err){
    print(err.toString());
  }
  }
  Future<void> postComment(String postId,String text,String uid,String name,String profileImage)async {
  try{
  if(text.isNotEmpty){
    String commnetId = const Uuid().v1();
    await _firestore.collection('posts').doc(postId).collection('comments').doc(commnetId).set({
   'profileImage':profileImage,
   'name':name,
   'uid':uid,
   'text':text,
   'commentId':commnetId,
   'datePublished':DateTime.now()
    });
  }
  else{
    print("comment text is empty");
  }
  }
  catch(err){
    print(err.toString());
  }
  }

  Future<void>deletePost(String postId) async{
    try{
    await _firestore.collection('posts').doc(postId).delete();
    }
    catch(err){
      print(err.toString());
    }
  }

}
