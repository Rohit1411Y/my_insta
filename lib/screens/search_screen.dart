import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_insta/screens/profile_screen.dart';
import 'package:my_insta/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
 
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: mobilebackgroundColor,
        title: TextFormField(
          controller:  searchController,
          decoration: const InputDecoration(
            labelText: 'Search'
          ),
        onFieldSubmitted: (value) {
        setState(() {
          searchController.text!=""? isShowUsers = true: isShowUsers = false;
        });
        },
        ),
      ),
      body: isShowUsers?  FutureBuilder(future: FirebaseFirestore.instance.collection('users').
      where('username',isGreaterThanOrEqualTo: searchController.text,).get(),
       builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context,index){
            return InkWell(
                onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=>
                ProfileScreen(uid:(snapshot.data! as dynamic ).docs[index]['uid'])));
          },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    (snapshot.data! as dynamic).docs[index]['photoUrl']
                  ),
                ),
                title: Text((snapshot.data! as dynamic).docs[index]['username'],),
              ),
            );
          });
       },
       ): 
       FutureBuilder(
        future:  FirebaseFirestore.instance.collection('posts').get(), 
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
     else{     
 return GridView.custom(
  gridDelegate: SliverQuiltedGridDelegate(
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
   
    repeatPattern: QuiltedGridRepeatPattern.inverted,
    pattern: [
      QuiltedGridTile(2, 2),
      QuiltedGridTile(1, 1),
      QuiltedGridTile(1, 1),
      QuiltedGridTile(1, 2),
    ],
  ),
  childrenDelegate: SliverChildBuilderDelegate(
    childCount: ((snapshot.data! as dynamic).docs.length) as int,
    (context, index) =>Image.network((snapshot.data!as dynamic).docs[index]['postUrl']),
  ),
);
     }


        })
    );
  }
}