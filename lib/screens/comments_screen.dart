import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/providers/user_provider.dart';
import 'package:my_insta/resources/firestore_methods.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:my_insta/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentsController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobilebackgroundColor,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .snapshots(),
       builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else{
       return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index)=>CommentCard(
          snap:snapshot.data!.docs[index].data(),
        ));
        }
       },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userModel.photoUrl),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: commentsController,
                  decoration: InputDecoration(
                    hintText: "comment as ${userModel.username}",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                FirestoreMethods().postComment(
                    widget.snap['postId'],
                    commentsController.text,
                    userModel.uid,
                    userModel.username,
                    userModel.photoUrl);
                    setState(() {
                      commentsController.text = '';
                    });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text(
                  'Post',
                  style: TextStyle(color: blueColor),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
