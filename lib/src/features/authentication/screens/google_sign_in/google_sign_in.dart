// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount? get user => _user;

//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/features/authentication/screens/dashboard/dashboard.dart';

class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the Google Authentication flow
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    // Authenticate with Firebase using the Google token
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    print('signed in with Google: ${user!.displayName}');

    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: () async {
            final UserCredential userCredential = await signInWithGoogle()
                .whenComplete(() => Get.to(Dashboard()));
            // TODO: Navigate to the next screen after sign-in
          },
        ),
      ),
    );
  }
}
