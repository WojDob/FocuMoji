// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../home.dart';
// import 'package:provider/provider.dart';
// import '../models/models.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   Future<void> _signInAndNavigate(BuildContext context) async {
//     final UserCredential userCredential = await signInWithGoogle();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (BuildContext context) => ChangeNotifierProvider(
//           create: (context) => TabManager(),
//           builder: (context, child) => Home(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String? userEmail = user?.email;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userEmail ?? 'Not Logged In'),
//       ),
//       body: Center(
//         child: SizedBox(
//           width: 200,
//           height: 40, // Adjust the width as needed
//           child: SignInButton(
//             Buttons.Google,
//             onPressed: () {
//               _signInAndNavigate(context);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   // Disconnect the current user if any
//   await googleSignIn.disconnect();

//   // Start the authentication flow
//   final GoogleSignInAccount? account = await googleSignIn.signIn();

//   // Cancel the sign-in flow if the user cancels or no account is selected
//   if (account == null) {
//     throw FirebaseAuthException(
//       code: 'user-cancelled',
//       message: 'User cancelled the sign-in process.',
//     );
//   }

//   // Obtain the auth details from the selected account
//   final GoogleSignInAuthentication googleAuth = await account.authentication;

//   // Create a new credential
//   final OAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   // Sign in with the credential
//   return FirebaseAuth.instance.signInWithCredential(credential);
// }
