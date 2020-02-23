import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  _iosBottomSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
              title: Text('Add photo'),
              actions: <Widget>[
                CupertinoActionSheetAction(
                    onPressed: () => print('Camera'),
                    child: Text('Take photo')),
                CupertinoActionSheetAction(
                    onPressed: () => print('Gallery'),
                    child: Text('Choose from gallery')),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ));
        });
  }

  _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Add photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take photo'),
                onPressed: () => print('Camera'),
              ),
              SimpleDialogOption(
                child: Text('Choose from gallery'),
                onPressed: () => print('Gallery'),
              ),
              SimpleDialogOption(
                child: Text('Cancel', style: TextStyle(color: Colors.redAccent),),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Create post',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add), onPressed: () => print('add post'))
          ],
        ),
        body: Column(children: <Widget>[
          GestureDetector(
            onTap: _showSelectImageDialog,
            child: Container(
              height: width,
              width: width,
              color: Colors.grey[300],
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white70,
                size: 170,
              ),
            ),
          )
        ]));
  }
}
