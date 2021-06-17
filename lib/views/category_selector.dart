import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/blocs/note_blocs.dart';
import 'package:nevis/blocs/note_events.dart';
import 'package:nevis/blocs/note_states.dart';
import 'package:nevis/model/category_model.dart';
import 'package:nevis/views/custom_data.dart';
import 'package:nevis/views/spear_menu2/spear_menu2.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final GlobalKey btnKey = GlobalKey();
  final List<CustomData> menuList = [];
  CategoryModel currentCategory;

  String selectedMenu = "All";

  @override
  Widget build(BuildContext context) {
    SpearMenu.context = context;
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteIsLoaded) {
        List<CategoryModel> categories = state.getCategories;
        return loadCategoriesView(categories);
      }
      return Text("problem happened");
    });
  }

  Widget loadCategoriesView(List<CategoryModel> categories) {
    return Container(
        child: GestureDetector(
            key: btnKey,
            onTap: () {
              menuData(btnKey, categories);
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

  void menuData(GlobalKey btnKey, List<CategoryModel> categories) {
    if (menuList.isEmpty) {
      menuList.clear();
      currentCategory = categories[0];
      for (int i = 0; i < categories.length; i++) {
        menuList.add(CustomData(categories[i], false));
      }
    }

    List<MenuItemProvider> setData = [];
    setData.clear();
    for (var io in menuList) {
      print("Result : " + io.category.name);
      setData.add(MenuItem(title: io.category.name, isActive: io.isShow));
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
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    menuList.map((element) {
      if (item.menuTitle == element.category.name) {
        element.isShow = true;
        CategoryModel category = CategoryModel();
        category = element.category;
        print("category id isssss"+category.id.toString());
        setState(() {
          selectedMenu = element.category.name;
          print(category.name);
          noteBloc.add(FetchNoteEvent(category: category));
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
