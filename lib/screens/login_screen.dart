import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/signup_screen.dart';
import '../components/Roundedbutton.dart';
import '../components/textfield.dart';
import '../services/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key,required this.ontap});
  final void Function() ontap;
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  //login method
  void login(){
       final auth = AuthService();
       try {
         auth.signInWithEmailPassword(
             _emailcontroller.text, _passwordcontroller.text);
       }
       catch(e) {
         showDialog(context: context,
             builder: (context)=>AlertDialog(
               title: Text(e.toString()),
             ),);
       }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/chat.png',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(height: 20,),
                //informational text & logo
                Text(
                  'Login Here...',
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 25),
                ),
                const SizedBox(height: 30,),

                //form for email & password
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFields(
                        obstxt: false,
                        controllers: _emailcontroller,
                        text: 'e-mail',
                        icon: Icon(Icons.email,color: Theme.of(context).colorScheme.inversePrimary),
                        errortext: 'emailrequired',
                      ),
                      const SizedBox(height: 20,),
                      TextFields(
                        obstxt: true,
                        controllers: _passwordcontroller,
                        text: 'password',
                        icon: Icon(Icons.password,color: Theme.of(context).colorScheme.inversePrimary),
                        errortext: 'password required',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                //login button
                RoundButton(
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  text: 'login',
                ),
                const SizedBox(height: 60,),
                InkWell(
                  onTap: widget.ontap,
                  child: Text(
                    'don\'t have an account? create one',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
