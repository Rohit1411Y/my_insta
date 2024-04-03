import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  

  @override
  Widget build(BuildContext context) {
     UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(userModel.username)),
    );
  }
}