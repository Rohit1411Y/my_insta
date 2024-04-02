import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:my_insta/resources/storage_methods.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String? email,
    required String ?password,
    required String ? username,
    required String?bio,
    required Uint8List ?file,
  }) async {
    String res = "some error occured";
    try {
      if (email!.isNotEmpty ||
          password!.isNotEmpty ||
          username!.isNotEmpty ||
          bio!.isNotEmpty ||
          file != null
          ) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);

      String photoUrl = await StorageMethods().uploadImageToStorage("profile", file!, false);      
      
      await _firestore.collection('users').doc(credential.user!.uid).set(
        {
          'username':username,
          'uid':credential.user!.uid,
          'email':email,
          'bio':bio,
          'followers':[],
          'following':[],
          'photoUrl':photoUrl



        }
      );
      res = "success";
          
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  Future<String>loginUser({required String email, required String password})async {

  String res = "Some error occured";
  try{
    if(email.isNotEmpty||password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    }
    else{
      res = "please enter all the fields";
    }
  }
  catch(err){
    res = err.toString();
  }
  return res;

  }
}
