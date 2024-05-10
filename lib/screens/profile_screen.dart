import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/services/auth/auth_service.dart';

import '../components/Roundedbutton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final _usernameController = TextEditingController();

  void updateUsername() {
    final auth = AuthService();
    auth.updateProfile(_usernameController.text,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('P R O F I L E') ,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getImageFromGallery();
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                          child: _image == null? Image.asset("assets/profile.png",) : Image.file(_image!,fit: BoxFit.cover,),
                        )
                    ),),
                ),
              ),
              const SizedBox(height: 25,),
               Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                child: TextField(
                  controller: _usernameController,
                    decoration: const InputDecoration(
                  focusColor: Colors.black,
                 hintText: 'username',
                  // prefixText: 'username',
                )),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: updateUsername,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(168, 167, 167, 1.0)
                    ),
                    child: const Center(
                      child: Text('upload' ,
                        style: TextStyle(
                            color: Colors.black
                        ),), ),
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}

