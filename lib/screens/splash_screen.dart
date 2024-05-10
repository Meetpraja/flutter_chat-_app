import 'package:flutter/material.dart';

import '../services/auth/auth_gate.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async{
    await Future.delayed(const Duration(milliseconds: 3000),(){});
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthGate()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/chat.png',
              height: 70,
              width: 70,
            ),
            const SizedBox(height: 20,),
            Text(
              'welcome to Talkative...',
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            )
          ],
        ),
      ),
    );
  }
}
