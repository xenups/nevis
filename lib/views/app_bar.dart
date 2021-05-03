import 'package:flutter/material.dart';
import 'package:nevis/views/category_selector.dart';

class NevisAppBar extends PreferredSize {
  NevisAppBar() : super();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
      // toolbarHeight: 40.0,
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: CategorySelector(),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 26.0,
              ),
            )),
      ],
    );
  }
}