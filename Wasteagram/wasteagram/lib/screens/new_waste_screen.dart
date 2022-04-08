import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/widgets/wasted_food_form.dart';

class NewWasteScreen extends StatefulWidget {

  static const routeName = 'newWaste';
  const NewWasteScreen({Key? key}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => NewWasteScreenState();
}

class NewWasteScreenState extends State<NewWasteScreen> {
  
  File? image;
  final picker = ImagePicker();

  void getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    image = File(pickedFile!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Waste'), centerTitle: true),
      body: layout(),
    );
  }

  Widget layout() {
    if (image == null){
      return noImage(context);
    } else {
      return withImage();
    }
  }

  Widget noImage(BuildContext context) {
    return Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Choose a photo from your device for upload',
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(100, 50))
            ),
            child: Text(
              'Select Photo',
              style: Theme.of(context).textTheme.headline5
            ),
            onPressed: () {
              getImage(ImageSource.gallery);
            }
          ),
        ),
        const SizedBox(width: 10),
        Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Use your camera to take a photo for upload',
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(100, 50))
            ),
            child: Text(
              'Take Photo', 
              style: Theme.of(context).textTheme.headline5),
            onPressed: () {
              getImage(ImageSource.camera);
            }
          ),
        ),
      ],
    ));
  }

  Widget withImage() {
    return const NewEntryForm();
  }
}