import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sofigram/screens/activity_screen.dart';
import 'package:sofigram/screens/create_post_screen.dart';
import 'package:sofigram/screens/feed_screen.dart';
import 'package:sofigram/screens/profile_screen.dart';
import 'package:sofigram/screens/search_screen.dart';

class HomeSreen extends StatefulWidget {

    final String userId;

  HomeSreen({this.userId});

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Sofigram',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Billabong', fontSize: 35),
          )),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentTab,
          activeColor: Colors.black,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(index, duration: Duration(milliseconds:200), curve: Curves.easeIn);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 32)),
            BottomNavigationBarItem(icon: Icon(Icons.search, size: 32)),
            BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 32)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications, size: 32)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 32)),
          ]),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(userId: widget.userId,)
        ],
        onPageChanged: (int index){
          setState(() {
            _currentTab = index;
          });
        },
      ),
    );
  }
}
