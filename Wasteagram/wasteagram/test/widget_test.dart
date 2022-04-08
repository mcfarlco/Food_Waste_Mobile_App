import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  testWidgets('1: Post created from Map should have appropriate property values', (WidgetTester tester) async {
    final date = Timestamp.fromDate(DateTime.parse('2020-01-01'));
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost.fromJSON({
      'post_date' : date,
      'image_url' : url,
      'waste_quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude,
    });

    expect(foodWastePost.timestamp, date);
    expect(foodWastePost.imageUrl, url);
    expect(foodWastePost.wasteQuantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  testWidgets('2: Post created from Map should have appropriate property values', (WidgetTester tester) async {
    final date = Timestamp.fromDate(DateTime.parse('2022-01-01'));
    const url = 'oregonstate.edu';
    const quantity = 42;
    const latitude = 40.0067;
    const longitude = 83.0305;

    final foodWastePost = FoodWastePost.fromJSON({
      'post_date' : date,
      'image_url' : url,
      'waste_quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude,
    });

    expect(foodWastePost.timestamp, date);
    expect(foodWastePost.imageUrl, url);
    expect(foodWastePost.wasteQuantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });
}
