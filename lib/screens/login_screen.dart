import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _signInAndNavigate(BuildContext context) async {
    final UserCredential userCredential = await signInWithGoogle();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider(
          create: (context) => TabManager(),
          builder: (context, child) => Home(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(userEmail ?? 'Not Logged In'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 40, // Adjust the width as needed
          child: SignInButton(
            Buttons.Google,
            onPressed: () {
              _signInAndNavigate(context);
            },
          ),
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

class SignInWithGoogleButton extends StatelessWidget {
  final Function() onPressed;

  const SignInWithGoogleButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      onPressed: onPressed,
    );
  }
}
