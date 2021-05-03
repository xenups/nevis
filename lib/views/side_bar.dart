import 'dart:ui';

import 'package:flutter/material.dart';

class NevisDrawer extends StatelessWidget {
  TextStyle menuTextStyle = TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .white, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: SafeArea(
            child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(60, 99, 130, 1.0),
                    Color.fromRGBO(7, 153, 146, 1.0),
                  ],
                )),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("A"),
                ),
                accountName: Text(
                  "Amir Lesani",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text("xenups@gmail.com",
                    style: TextStyle(color: Colors.white)),
                otherAccountsPictures: <Widget>[],
              ),
              ListTile(
                  title: Text(
                    "Share",
                    style: (menuTextStyle),
                  ),
                  leading: Icon(Icons.send),
                  onTap: () => _onTapItemDrawer(context, "Sixth page")),
              ListTile(
                  title: Text(
                    "Settings",
                    style: (menuTextStyle),
                  ),
                  leading: Icon(Icons.settings),
                  onTap: () => _onTapItemDrawer(context, "Third page")),
              Divider(),
              ListTile(
                  title: Text(
                    "Rate us",
                    style: (menuTextStyle),
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () => _onTapItemDrawer(context, "Second page")),
            ],
          ),
        )));
  }

  void _onTapItemDrawer(_, String title) {
    print("drawer clicked");
  }
}
