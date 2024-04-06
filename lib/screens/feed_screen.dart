import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:my_insta/widgets/post_card.dart';

class MyFeed extends StatelessWidget {
  const MyFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobilebackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset("assets/ic_instagram.svg",
        color: primaryColor,
        height: 32,
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.messenger_outline,
          ),
          ),
        ],

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
            
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: 
            (context,
            index)=>PostCard());

        },)
    );
  }
}