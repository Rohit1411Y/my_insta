import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_insta/firebase_options.dart';
import 'package:my_insta/screens/login_screen.dart';
import 'package:my_insta/responsive/mobile_screen_layout.dart';
import 'package:my_insta/responsive/responsive_layout_screen.dart';
import 'package:my_insta/responsive/web_screen_layout.dart';

import 'package:my_insta/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
     options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my_insta',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobilebackgroundColor,
      ),
      home:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.hasData){
            return const ResponsiveLayoutScreen(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout());
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('${snapshot.hasError}'),
            );
          }
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const LoginScreen();
      },
      )
       //const ResponsiveLayoutScreen(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout()),
    );
  }
}

