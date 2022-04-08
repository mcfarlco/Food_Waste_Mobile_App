import 'package:flutter/material.dart';
import '../screens/new_waste_screen.dart';
import '../screens/waste_detail_screen.dart';
import '../screens/waste_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final routes = {
    NewWasteScreen.routeName : (context) => const NewWasteScreen(),
    WasteDetailScreen.routeName : (context) => const WasteDetailScreen(),
    WasteListScreen.routeName : (context) => const WasteListScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Services',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      routes: routes,
    );
  }
}

