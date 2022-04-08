import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import '../models/new_waste_dto.dart';
import '../screens/new_waste_screen.dart';


class NewEntryForm extends StatefulWidget {
  const NewEntryForm({Key? key}) : super(key: key);

  @override
  State<NewEntryForm> createState() => _NewEntryFormState();
}

class _NewEntryFormState extends State<NewEntryForm> {
  LocationData? locationData;
  var locationService = Location();
  final formKey = GlobalKey<FormState>();
  final newWasteFields = NewWasteDTO();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }

    locationData = await locationService.getLocation();
  }

  Future postImage(image) async {
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }
  
  @override
  Widget build(BuildContext context) {
    final image = context.findAncestorStateOfType<NewWasteScreenState>()!.image;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Image.file(image!)),
            const SizedBox(height: 20),
            Flexible(child: itemQuantityField()),
          ],
        ),
      ),
      floatingActionButton: uploadButton(context, image),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget itemQuantityField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Number of Wasted Items',
        ),
        style: Theme.of(context).textTheme.headline6,
        validator: validateItemQuantity,
        onSaved: saveItemQuantity
      )
    );
  }

  String? validateItemQuantity(String? value) {
    if (value!.isEmpty){
      return 'Please Enter a Waste Amount.';
    } else {
      return null;
    }
  }

  void saveItemQuantity(String? value) {
    newWasteFields.wasteQuantity = int.parse(value!);
  }

  Widget uploadButton(BuildContext context, var image) {
    return SizedBox(
      width: 1200,
      height: 60,
      child: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Create new post from your entry.',
        child: FloatingActionButton(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.upload_file),
          onPressed: () {
            asyncDelay(context);
            validateSaveUploadAndPop(image);
          }
        ),
      ),
    );
  }

  void validateSaveUploadAndPop(image) async{
    if (formKey.currentState!.validate()) {
      newWasteFields.timestamp = DateTime.now();
      newWasteFields.imageUrl = await postImage(image);
      newWasteFields.latitude = locationData!.latitude!;
      newWasteFields.longitude = locationData!.longitude!;
      formKey.currentState!.save();
      newWasteFields.postEntry();
      // Pop loading circle, then page.
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  // Used from https://stackoverflow.com/questions/61538071/show-circularprogressindicator-in-front-in-flutter
  asyncDelay(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  }

}
