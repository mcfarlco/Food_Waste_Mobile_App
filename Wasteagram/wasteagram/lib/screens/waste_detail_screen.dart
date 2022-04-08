import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {

  static const routeName = 'wasteDetail';
  const WasteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FoodWastePost receviedEntry = ModalRoute.of(context)!.settings.arguments as FoodWastePost;
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram'), centerTitle: true),
      body: layout(context, receviedEntry),
    );
  }

  Widget layout(BuildContext context, FoodWastePost post) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          formatDate(context, post.timestamp),
          const SizedBox(height: 20),
          Flexible(child: Image.network(
            post.imageUrl,
          )),
          const SizedBox(height: 20),
          Text(
            'Items: ${post.wasteQuantity.toString()}',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 20),
          Text(
            '(${post.latitude.toString()}, ${post.longitude.toString()})',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget formatDate(BuildContext context, Timestamp timestamp){
    return Text(
      DateFormat('EEEE, MMMM d, y').format(DateTime.parse(timestamp.toDate().toString())),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}