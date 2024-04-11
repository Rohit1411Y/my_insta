import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/providers/user_provider.dart';
import 'package:my_insta/screens/add_post.dart';
import 'package:my_insta/screens/feed_screen.dart';
import 'package:my_insta/screens/profile_screen.dart';
import 'package:my_insta/screens/search_screen.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
    const MyFeed(),
   
    const SearchScreen(),
    const AddPostSCreen(),
    const Text('notifications'),
     ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),

  ];
  void onItemTaped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Center(child: widgetOptions.elementAt(selectedIndex),),
      bottomNavigationBar: BottomNavigationBar(
           backgroundColor: mobilebackgroundColor,
        items: const<BottomNavigationBarItem>[
        
          BottomNavigationBarItem(icon:Icon(Icons.home),
          label: '',
         backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search),
          label: '',
         backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle),
          label: '',
          backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),
          label: '',
          backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: '',
          backgroundColor: primaryColor
          )
          ],

          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          onTap: onItemTaped,
          elevation: 5,
          ),
    );
  }
}
