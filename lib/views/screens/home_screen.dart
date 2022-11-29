import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[_screenIndex],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
        },
        currentIndex: _screenIndex,
        backgroundColor: backgroundColor,
        activeColor: buttonColor,
        inactiveColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
          ),
        ],
      ),
    );
  }
}
