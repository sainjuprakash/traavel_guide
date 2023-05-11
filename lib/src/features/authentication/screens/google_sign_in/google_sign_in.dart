// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:login_setup/src/features/authentication/screens/dashboard/dashboard.dart';

// // class GoogleSignInScreen extends StatefulWidget {
// //   const GoogleSignInScreen({Key? key}) : super(key: key);

// //   @override
// //   _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
// // }

// // class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
// //   final GoogleSignIn _googleSignIn = GoogleSignIn();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   bool _isSigningIn = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Sign in with Google'),
// //       ),
// //       body: Center(
// //         child: _isSigningIn
// //             ? CircularProgressIndicator()
// //             : OutlinedButton(
// //                 onPressed: () async {
// //                   setState(() {
// //                     _isSigningIn = true;
// //                   });

// //                   GoogleSignInAccount? user = await _googleSignIn.signIn();

// //                   if (user != null) {
// //                     GoogleSignInAuthentication googleAuth =
// //                         await user.authentication;

// //                     final AuthCredential credential =
// //                         GoogleAuthProvider.credential(
// //                       accessToken: googleAuth.accessToken,
// //                       idToken: googleAuth.idToken,
// //                     );

// //                     try {
// //                       final UserCredential userCredential =
// //                           await _auth.signInWithCredential(credential);

// //                       final User? firebaseUser = userCredential.user;

// //                       if (firebaseUser != null) {
// //                         Navigator.of(context).pushReplacement(
// //                           MaterialPageRoute(
// //                             builder: (context) => Dashboard(),
// //                           ),
// //                         );
// //                       }
// //                     } catch (e) {
// //                       print(e);
// //                     }

// //                     setState(() {
// //                       _isSigningIn = false;
// //                     });
// //                   }
// //                 },
// //                 child: Text('Sign in with Google'),
// //               ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;

//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
// }
