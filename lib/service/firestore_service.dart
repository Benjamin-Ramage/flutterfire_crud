import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_crud/models/item.dart';

final CollectionReference<Map<String, dynamic>> itemsCollection =
FirebaseFirestore.instance.collection('items');

Future<void> addItem(Item item) async {
  Timestamp timestamp = Timestamp.now();
  await itemsCollection.add({
    ...item.toMap(),
    'timestamp': timestamp,
  });
}

Future<void> updateItem(String itemId, Item item) async {
  await itemsCollection.doc(itemId).set(
    {
      ...item.toMap(),
      'timestamp': FieldValue.serverTimestamp(),
    },
    SetOptions(merge: true),
  );
}

Future<void> deleteItem(String itemId) async {
  await itemsCollection.doc(itemId).delete();
}

Future<void> updateItemOrder(String itemId, int newOrder) async {
  try {
    await itemsCollection.doc(itemId).update({
      'order': newOrder,
    });
  } catch (e) {
    print('Error updating item order: $e');
  }
}