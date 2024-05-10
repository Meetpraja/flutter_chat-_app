import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/drawer.dart';
import 'package:social_media/components/user_tile.dart';
import '../services/auth/auth_service.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logOut() {
    final auth = AuthService();
    auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('H O M E'),
        // actions: [
        //   IconButton(onPressed: logOut,
        //       icon: const Icon(Icons.logout))
        // ],
      ),
      drawer: const MyDrawer(),
      body: _userList(),
    );
  }

  Widget _userList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Text('loading');
          }
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => _userListItem(doc))
                    .toList());
          }
          return Container();
        });
  }

  Widget _userListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return UserTile(
        img: data['profile'],
          text: data['userName'],
          ontap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  username: data['userName'],
                  receiverUserId: data['uid'],
                ),
              ),
            );
          });
      // return ListTile(
      //   title: Text(data['email']),
      //   onTap: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => ChatPage(
      //                   receiverEmail: data['email'],
      //                   receiverUserId: data['uid'],
      //                 ),
      //         ),
      //     );
      //   },
      // );
    } else {
      return Container();
    }
  }

  // Widget _userList() {
  //   print('reached succesfully.2');
  //   return StreamBuilder(
  //       stream: _chatservice.getUsersStream(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Text('error');
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Text('loading');
  //         }
  //         return ListView(
  //           children: snapshot.data!
  //               .map<Widget>((userData) => _userListItem(userData, context))
  //               .toList(),
  //         );
  //       });
  // }
  //
  // Widget _userListItem(
  //     Map<String, dynamic> userData,
  //     BuildContext context) {
  // print('reached succesfully.3');
  //   //display all user , not current
  //   return UserTile(
  //     text: userData["email"],
  //     ontap: () {
  //       //goto chat
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => ChatPage(
  //                     receiveEmail: userData["email"],
  //                   ),
  //           ),
  //       );
  //     },
  //   );
  // }
}
