
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            'uid' : userCredential.user!.uid,
            'email' : email,
          },SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }

  }

  //sign up
  Future<UserCredential> signUpwithEmailPassword(String email, password,String userName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection("users").doc(userCredential.user!.uid).set(
          {
            'profile' : 'assets/profile.png',
            'uid' : userCredential.user!.uid,
            'email' : email,
            'userName' : userName,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  void takeusername(){
    _firestore.collection("users").doc(_auth.currentUser!.uid).snapshots();
  }

  //profile
  void updateProfile(String newusername){
    _firestore.collection("users").doc(_auth.currentUser!.uid).update({
      'userName' : newusername,
    });
  }


  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
  //erroes
}
