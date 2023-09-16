import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_projecct/Utils/ImagesUrls.dart';
import 'package:new_projecct/view/Screens/DashBoardPage.dart';
import 'package:new_projecct/view/Widgets/CustomDialogBox.dart';

class GoogleSinginClass {
  static Future<void> signup(BuildContext context) async {
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

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (result != null) {
        showDialog(context: context,
            builder: (BuildContext context){
              return  CustomDialogBox(title: 'Login', descriptions: 'Login Successfully', text: 'Yes', img: Image.asset(ImageUrls.check_url),);
            }
        );

      }

    }
  }
}
