import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/screens/login_screen.dart';

import '../components/Roundedbutton.dart';
import '../components/textfield.dart';
import '../services/auth/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.ontap});
  final void Function() ontap;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void register() {
    final auth = AuthService();
    if (_passwordcontroller.text == _confirmpasscontroller.text) {
      try {
        auth.signUpwithEmailPassword(_emailcontroller.text,
            _passwordcontroller.text, _userNamecontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("password not matched"),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasscontroller = TextEditingController();
  final _userNamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.black,
      //   title: const Text('register Here...'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //informational text & logo
                Image.asset(
                  'assets/chat.png',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'register Here...',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 40,
                ),
                //form for email & password
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFields(
                        obstxt: false,
                        controllers: _userNamecontroller,
                        text: 'username',
                        icon: const Icon(Icons.email),
                        errortext: 'usernamerequired',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields(
                        obstxt: false,
                        controllers: _emailcontroller,
                        text: 'e-mail',
                        icon: const Icon(Icons.email),
                        errortext: 'emailrequired',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields(
                        obstxt: true,
                        controllers: _passwordcontroller,
                        text: 'password',
                        icon: const Icon(Icons.password),
                        errortext: 'password required',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields(
                        obstxt: true,
                        controllers: _confirmpasscontroller,
                        text: 'confirm password',
                        icon: const Icon(Icons.password),
                        errortext: 'please confirm password',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //login button
                RoundButton(
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                  text: 'sign up',
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: widget.ontap,
                  child: Text(
                    'already register? login',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
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
