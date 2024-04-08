import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/providers/user_provider.dart';
import 'package:my_insta/resources/firestore_methods.dart';
import 'package:my_insta/screens/comments_screen.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:my_insta/utils/utils.dart';
import 'package:my_insta/widgets/like_animation.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  
  const PostCard({super.key,required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLength = 0;
  bool isLikeAnimating = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  void getComments()async{
  try{
   QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts').
   doc(widget.snap['postId']).collection('comments').get();
   commentLength = snap.docs.length;
  }
  catch(err){
    showSnackBar(err.toString(), context);
  }
  setState(() {
    
  });
  }
  @override
  Widget build(BuildContext context) {
    final UserModel  userModel = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobilebackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                     widget.snap['profileImage']),
                ),
                 Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: ['delete']
                                      .map((e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
          //Image Section
          GestureDetector(
            onDoubleTap: () async{
            await  FirestoreMethods().likePost(widget.snap['postId'],userModel.uid,widget.snap['likes']);
              setState(() {
               
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl']
                   ,
                    fit: BoxFit.cover,),
               
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating?1:0 ,
                child: LikeAnimation(isAnimation: 
                isLikeAnimating,
                duration: const Duration(
                  milliseconds: 400
                ),
                onEnd: (){
                 setState(() {
                   isLikeAnimating = false;
                 });
                },child: 
                const Icon(Icons.favorite,color: Colors.white,size: 100,),
                ),
              ),
              
            
            ],
            ),
          ),
          //Like comment section

          Row(
            children: [
              LikeAnimation(
                isAnimation: widget.snap['likes'].contains(userModel.uid),
                smallLike: true,
                child: IconButton(onPressed: ()async{
                await  FirestoreMethods().likePost(widget.snap['postId'],userModel.uid,widget.snap['likes']);
                },
                 icon: widget.snap['likes'].contains(userModel.uid)? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ):const Icon(Icons.favorite_outline),
                ),
              ),
                 IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CommentsScreen(
                    snap: widget.snap,
                  )));
              }, icon: const Icon(
                Icons.comment_outlined,
               
              ),

              ),
                 IconButton(onPressed: (){

              }, icon: const Icon(
                Icons.send,
         
              )
              ),
              Expanded(child: Align(alignment: Alignment.bottomRight,
              child: IconButton(icon: const Icon(Icons.bookmark_border),
              onPressed: (){

              },
              ) ,
              )
              )

            ],
          ),
          //Description and no of comments
         Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
                child: Text('${widget.snap['likes'].length} likes',
                style: Theme.of(context).textTheme.bodyMedium,),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(text:  TextSpan(
                  style:  const TextStyle(color: primaryColor),
                  children: [
                    TextSpan(
                      text: '${widget.snap['username']} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                      TextSpan(
                      text: widget.snap['description'],
                     
                    ),

                  ]
                )
                ),
              ),
              //comments

              InkWell(
                onTap: (){

                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:  Text("view all $commentLength comments",
                  style: TextStyle(fontSize: 16,color: secondaryColor),),
                ),
              ),

              Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:  Text(DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(fontSize: 16,color: secondaryColor),),
                ),

            ],
          ),
         )
        
        ],
      ),
    );
  }
}
