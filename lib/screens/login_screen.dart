import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_insta/resources/auth_methods.dart';
import 'package:my_insta/responsive/mobile_screen_layout.dart';
import 'package:my_insta/responsive/responsive_layout_screen.dart';
import 'package:my_insta/responsive/web_screen_layout.dart';
import 'package:my_insta/screens/sign_up_screen.dart';
import 'package:my_insta/utils/colors.dart';
import 'package:my_insta/utils/utils.dart';
import 'package:my_insta/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  @override
  void dispose() {
     emailController.dispose();
     passwordController.dispose();
    super.dispose();
  }

  void loginUser() async{
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().loginUser(email: emailController.text,
    password: passwordController.text);
    setState(() {
      isloading = false;
    });
    if(res=="success"){
      Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=>const ResponsiveLayoutScreen(
        webScreenLayout:  WebScreenLayout(),
       mobileScreenLayout:  MobileScreenLayout())));
    }
    else{
      showSnackBar(res, context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2,child: Container(),),
              SvgPicture.asset('assets/ic_instagram.svg',
              color: primaryColor ,
               height: 64,),
               const SizedBox(height: 64,),
               TextInputField(textEditingController: emailController,
                hintText: "enter your email", 
                textInputType: TextInputType.emailAddress),
                const SizedBox(height: 24,),
                TextInputField(textEditingController: passwordController,
                 isPass: true,
                 hintText: 'enter your password',
                 textInputType: TextInputType.text),
                 const SizedBox(height: 24,),
                InkWell(
                  onTap: (){
                     loginUser();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                     color: blueColor,
                    ),
                   
                    child:isloading? const Center(child: CircularProgressIndicator(),) : const Text('Log in'),
                  ),
                ),
                Flexible(flex: 2,child: Container(),),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: (){
                       
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                      },
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("sign up",
                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    )
                  ],
                ) 

            ],
          ),
        )),
    );
  }
}