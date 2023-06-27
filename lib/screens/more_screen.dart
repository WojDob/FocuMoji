import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rewards_manager.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final rewardsProvider = context.watch<RewardsManager>();

    return SafeArea(
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
                child: Text('View Shared Preferences'),
              ),
              ElevatedButton(
                onPressed: () async {
                  rewardsProvider.rewards_count += 1;
                },
                child: Text('xd'),
              ),
              ElevatedButton(
                onPressed: () async {
                  rewardsProvider.add_reward(1);
                  rewardsProvider.changeEmoji();
                },
                child: Text(
                    "${rewardsProvider.emoji} ${rewardsProvider.rewards_count}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    final rewardsProvider = context.read<RewardsManager>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${rewardsProvider.emoji}"),
                ],
              ),
            ),
          ),
        );
      },
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
