import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/controller/LoginController.dart';
class GoogleSinginClass {
  static Future<void> signup(BuildContext context,LoginController controller) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
   // final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
      if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result != null) {
      var userEmail=  user!.email;
      var userName=user.displayName;
        controller.loginApi(userEmail!,userName!);
      }
    }
  }

}
