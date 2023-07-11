import 'package:flutter/material.dart';
import 'screens/set_timer_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/more_screen.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  static List<Widget> pages = <Widget>[
    const TimerScreen(),
    const RewardsScreen(),
    MoreScreen(),
  ];

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    // String? userEmail = user?.email;
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(userEmail ?? 'Not Logged In'),
          //   // title: const Text('FocuMoji'),
          // ),
          body: IndexedStack(
            index: tabManager.selectedTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: tabManager.selectedTab,
            onTap: (index) {
              tabManager.goToTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add_alarm_outlined),
                label: 'Timer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium),
                label: 'Rewards',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'More',
                backgroundColor: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}
