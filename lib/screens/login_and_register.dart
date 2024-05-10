import 'package:flutter/material.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/screens/signup_screen.dart';

class LoginAndRegister extends StatefulWidget{
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState()=> _LoginAndRegisterState();
}
class _LoginAndRegisterState extends State<LoginAndRegister>{

  bool showLoginpage = true;

  void togglePage(){
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginpage){
      return LoginScreen(ontap: togglePage,);
    }
    else {
      return SignupScreen(ontap: togglePage,);
    }
  }
}