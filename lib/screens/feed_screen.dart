import 'package:flutter/material.dart';
import 'package:sofigram/services/auth_service.dart';

class FeedScreen extends StatelessWidget {
  static final id = 'feed_screen';
  const FeedScreen({Key key}) : super(key: key);

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
      backgroundColor: Colors.blue,
      body: Center(
          child: FlatButton(
              onPressed: () => AuthService.logOut(context),
              child: Text('Logout'))),
    );
  }
}
