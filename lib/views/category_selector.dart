import 'package:flutter/material.dart';
import 'package:nevis/views/custom_data.dart';
import 'package:nevis/views/spear_menu2/spear_menu2.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final GlobalKey btnKey = GlobalKey();
  final List<CustomData> menuList = [];
  String selectedMenu = "All";

  @override
  Widget build(BuildContext context) {
    // SpearMenu.context = context;
    return Container(
        child: GestureDetector(
            key: btnKey,
            onTap: () {
              menuData(btnKey);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(selectedMenu),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.white,
                )
              ],
            )));
  }

  void menuData(GlobalKey btnKey) {
    if (menuList.isEmpty) {
      menuList.clear();
      menuList.add(CustomData('1', false));
      menuList.add(CustomData('2', false));
      menuList.add(CustomData('3', false));
      menuList.add(CustomData('Setting', false));
      menuList.add(CustomData('5', false));
      menuList.add(CustomData('6', false));
      menuList.add(CustomData('7', false));
      menuList.add(CustomData('8', false));
      menuList.add(CustomData('9', false));
      menuList.add(CustomData('11', false));
      menuList.add(CustomData('21', false));
      menuList.add(CustomData('13', false));
      menuList.add(CustomData('14', false));
      menuList.add(CustomData('15', false));
      menuList.add(CustomData('16', false));
      menuList.add(CustomData('17', false));
      menuList.add(CustomData('18', false));
      menuList.add(CustomData('122', false));
    }

    List<MenuItemProvider> setData = [];
    setData.clear();
    for (var io in menuList) {
      print("Result : " + io.name);
      setData.add(MenuItem(title: io.name, isActive: io.isShow));
    }

    SpearMenu menu = SpearMenu(
        //backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        items: setData,
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }

  void onClickMenu(MenuItemProvider item) {
    menuList.map((element) {
      if (item.menuTitle == element.name) {
        element.isShow = true;
        setState(() {
          selectedMenu = element.name;
        });
      } else {
        element.isShow = false;
      }
    }).toList();

    print('Click menu -> ${item.menuTitle}');
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
}
