import 'package:rcroom/firebaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class database {
  final CollectionReference databaseCollection = FirebaseFirestore.instance.collection("users");
  final _database = FirebaseFirestore.instance;
  final String? uid;
  database({this.uid});

  Future saveData(items) async {
    return await databaseCollection.doc(uid).set({
      'items': items
    });
  }
}