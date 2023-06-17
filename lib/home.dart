import 'package:flutter/material.dart';
import 'screens/timer_screen.dart';
import 'screens/medals_screen.dart';
import 'screens/more_screen.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

class Home extends StatelessWidget {
  static List<Widget> pages = <Widget>[
    TimerScreen(),
    MedalsScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
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
                label: 'Medals',
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
