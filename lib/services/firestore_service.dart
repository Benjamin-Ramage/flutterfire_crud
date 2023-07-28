
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference<Map<String, dynamic>> itemsCollection =
    FirebaseFirestore.instance.collection('items');

Future<void> addItem(String name, String description) async {
  await itemsCollection.add({
    'name': name,
    'description': description,
  });
}

Future<void> updateItem(String itemId, String name, String description) async {
  await itemsCollection.doc(itemId).set({
    'name': name,
    'description': description,
  }, SetOptions(merge: true));
}


Future<void> deleteItem(String itemId) async {
  await itemsCollection.doc(itemId).delete();
}