import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import '../models/food_waste_post.dart';
import '../widgets/camera_fab.dart';

class WasteListScreen extends StatefulWidget {

  static const routeName = '/';
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram'), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('waste_entries').orderBy('post_date').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
                  snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                FoodWastePost post = FoodWastePost.fromJSON(snapshot.data!.docs[index].data() as Map<dynamic, dynamic>);
                return Semantics(
                  button: true,
                  enabled: true,
                  onTapHint: 'Tap to view details of this post',
                  child: ListTile(
                    trailing: Text(
                      post.wasteQuantity.toString(), 
                      style: Theme.of(context).textTheme.headline5
                    ),
                    title: formatDate(post.timestamp),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        WasteDetailScreen.routeName, 
                        arguments: post
                      );
                    },
                  ),
                );
              }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Add a new post',
        child: CameraFab(context),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget formatDate(Timestamp timestamp){
    return Text(
      DateFormat('EEEE, MMMM d, y').format(DateTime.parse(timestamp.toDate().toString()))
    );
  }
}