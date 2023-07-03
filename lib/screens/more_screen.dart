import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rewards_manager.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardsProvider = context.watch<RewardsManager>();

    return Scaffold(
      appBar: AppBar(title: const Text('FocuMoji')),
      body: SafeArea(
        child: SizedBox(
          width: 300,
          height: 500,
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final sharedPrefs = await SharedPreferences.getInstance();
                    final storedEmojis =
                        sharedPrefs.getStringList('rewards') ?? [];
                    print(storedEmojis);
                  },
                  child: const Text('View Shared Preferences'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    rewardsProvider.addRandomEmojisDebug();
                  },
                  child: const Text('ADD 1000 EMOJIS'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pref = await SharedPreferences.getInstance();
                    await pref.clear();
                  },
                  child: const Text('Wipe Shared Preferences'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
// }
