import 'package:flutter/material.dart';
import 'package:social_media/screens/profile_screen.dart';
import 'package:social_media/screens/settings_screen.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  void logOut() {
    final auth = AuthService();
    auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(child: Image.asset('assets/chat.png',height: 50,width: 50,)),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: ListTile(
              title:  Text("H O M E",style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
              ),),
              leading: Icon(Icons.home_filled, color:Theme.of(context).colorScheme.inversePrimary),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: ListTile(
              title:  Text("S E T T I N G S",style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary
              ),),
              leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child: ListTile(
              title: Text("P R O F I L E",style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary
              ),),
              leading: Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary),
              onTap:(){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child: ListTile(
              title: Text("L O G O U T",style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary
              ),),
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              onTap:logOut,
            ),
          ),
        ],
      ),
    );
  }
}