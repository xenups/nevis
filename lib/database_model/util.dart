import 'package:get_it/get_it.dart';

import 'moor_db.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  // locator.registerSingleton(AppDatabase(openConnection()));
  locator.registerSingleton(AppDatabase());
}