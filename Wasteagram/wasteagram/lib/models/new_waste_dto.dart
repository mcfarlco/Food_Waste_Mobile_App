import 'package:cloud_firestore/cloud_firestore.dart';

class NewWasteDTO {
  late String imageUrl;
  late DateTime timestamp;
  late int wasteQuantity;
  late double latitude;
  late double longitude;

  void postEntry() {
    FirebaseFirestore.instance.collection('waste_entries').add({
      'post_date': timestamp,
      'image_url': imageUrl,
      'waste_quantity': wasteQuantity,
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}