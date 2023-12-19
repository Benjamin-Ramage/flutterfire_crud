import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String name;
  String description;
  Timestamp timestamp;

  Item({required this.name, required this.description, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'timestamp': timestamp,
    };
  }

  // Add a factory method to create a model instance from a Firestore document
  factory Item.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Item(
      name: data['name'],
      description: data['description'],
      timestamp: data['timestamp'],
    );
  }
}