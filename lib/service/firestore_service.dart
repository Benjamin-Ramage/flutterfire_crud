import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_crud/models/item.dart';

 final CollectionReference<Map<String, dynamic>> itemsCollection =
  FirebaseFirestore.instance.collection('items');

  Future<void> addItem(Item item) async {
    await itemsCollection.add(item.toMap());
  }

  Future<void> updateItem(String itemId, Item item) async {
    await itemsCollection.doc(itemId).set(
      item.toMap(),
      SetOptions(merge: true));
  }

  Future<void> deleteItem(String itemId) async {
    await itemsCollection.doc(itemId).delete();
  }

