import 'package:finance_tracker/pages/dashboard_page.dart';
import 'package:finance_tracker/pages/history_page.dart';
import 'package:finance_tracker/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = [
    const DashboardPage(),
    const HistoryPage(),
    const SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finance Tracker',
          style: TextStyle(
            fontFamily: 'Antonio',
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              label: 'dashboard',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.swap_vert_sharp), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ]),
    );
  }
}
