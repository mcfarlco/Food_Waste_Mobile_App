import 'package:flutter/material.dart';
import '../screens/new_waste_screen.dart';

Widget CameraFab(BuildContext context){
  return Builder(builder: (context) {
    return FloatingActionButton.large(
      backgroundColor: Colors.lightGreen,
      onPressed: () {
        Navigator.of(context).pushNamed(NewWasteScreen.routeName);
      },
      child: const Icon(Icons.camera_front)
    );
  });
}