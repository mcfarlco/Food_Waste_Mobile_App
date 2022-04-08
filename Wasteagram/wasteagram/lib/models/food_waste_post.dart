import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost {
  final String imageUrl;
  final Timestamp timestamp;
  final int wasteQuantity;
  final double latitude;
  final double longitude;

  FoodWastePost({
    required this.imageUrl, 
    required this.timestamp, 
    required this.wasteQuantity, 
    required this.latitude, 
    required this.longitude
  });

  factory FoodWastePost.fromJSON(Map<dynamic, dynamic> json) {
    return FoodWastePost(
      imageUrl: json['image_url'], 
      timestamp: json['post_date'], 
      wasteQuantity: json['waste_quantity'], 
      latitude: json['latitude'], 
      longitude: json['longitude']
    );
  }
}