import 'package:flutter/material.dart';
import 'habit_tracker_page.dart';
import 'journal_page.dart';
import 'gratitude_page.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _idx = 0;
  final List<Widget> _pages = [HabitTrackerPage(), JournalPage(), GratitudeJarPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: [
          NavigationDestination(icon: Icon(Icons.check_circle_outline), label: "Habits"),
          NavigationDestination(icon: Icon(Icons.book_outlined), label: "Journal"),
          NavigationDestination(icon: Icon(Icons.star_outline), label: "Jar"),
        ],
      ),
    );
  }
}