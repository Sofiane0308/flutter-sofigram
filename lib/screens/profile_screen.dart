import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sofigram/models/user_model.dart';
import 'package:sofigram/utilities/constants.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: usersRef.document(widget.userId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            User user = User.fromDoc(snapshot.data);
            print(user.name);
            print(user.bio);
            print(user.email);
            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: user.proflieImageUrl.isEmpty
                            ? AssetImage('assets/images/user_placeholder.png')
                            : CachedNetworkImageProvider(user.proflieImageUrl),
                      ),
                      Expanded(
                        child: Column(children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '12',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('posts',
                                        style: TextStyle(color: Colors.black54))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '380',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('following',
                                        style: TextStyle(color: Colors.black54))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '220',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('followers',
                                        style: TextStyle(color: Colors.black54))
                                  ],
                                ),
                              ]),
                          Container(
                            width: 200,
                            child: FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EditProfileScreen(user: user))),
                                child: Text('Edit Profile',
                                    style: TextStyle(fontSize: 18.0))),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Container(
                            height: 80,
                            child: Text(
                              user.bio,
                              style: TextStyle(fontSize: 15),
                            )),
                        Divider()
                      ]),
                )
              ],
            );
          }),
    );
  }
}
