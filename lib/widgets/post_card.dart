import 'package:flutter/material.dart';
import 'package:my_insta/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://png.pngitem.com/pimgs/s/130-1300400_user-hd-png-download.png'),
                ),
                const Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
                'https://media.istockphoto.com/id/636208094/photo/tropical-jungle.jpg?s=1024x1024&w=is&k=20&c=Zyc6mQ-VrbJIVjPOhrdzKlr6CpUdpcqT__bPJHJemXI=',
                fit: BoxFit.cover,),
           
          ),
          //Like comment section

          Row(
            children: [
              IconButton(onPressed: (){

              }, icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              )
              ),
                 IconButton(onPressed: (){

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
                child: Text("1024 likes",
                style: Theme.of(context).textTheme.bodyMedium,),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(text: const TextSpan(
                  style:  TextStyle(color: primaryColor),
                  children: [
                    TextSpan(
                      text: 'username  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                     TextSpan(
                      text: "Let's build Instagram",
                     
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
                  child:const  Text("view all 24 comments",
                  style: TextStyle(fontSize: 16,color: secondaryColor),),
                ),
              ),

              Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:const  Text("05/04/2024",
                  style: TextStyle(fontSize: 16,color: secondaryColor),),
                ),

            ],
          ),
         )
        
        ],
      ),
    );
  }
}
