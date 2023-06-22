import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('More Screen'),
        ),
        body: const Placeholder(
          color: Colors.purpleAccent,
        ));
  }

  // Future<void> _signOutAndNavigate(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => LoginScreen(),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('More Screen'),
  //     ),
  //     body: Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           _signOutAndNavigate(context);
  //         },
  //         child: Text('Log Out'),
  //       ),
  //     ),
  //   );
  // }
}
