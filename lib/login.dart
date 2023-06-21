import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

class LoginScreen extends StatelessWidget {
  Future<void> _signInAndNavigate(BuildContext context) async {
    final UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != null) {
      print('Successfully signed in');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => ChangeNotifierProvider(
            create: (context) => TabManager(),
            builder: (context, child) => Home(),
          ),
        ),
      );
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print('Sign-in failed');
      // Handle sign-in failure
    }
  }

  // Rest of the code...

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(userEmail ?? 'Not Logged In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("buton prezd");
            _signInAndNavigate(context);
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
