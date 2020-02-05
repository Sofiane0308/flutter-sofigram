import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSreen extends StatefulWidget {
  HomeSreen({Key key}) : super(key: key);

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {

  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Sofigram',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Billabong', fontSize: 35),
          )),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index){
          setState((){
              _currentTab = index;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 32)),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 32)),
        BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 32)),
        BottomNavigationBarItem(icon: Icon(Icons.notifications, size: 32)),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 32)),
      ]),
    );
  }
}
