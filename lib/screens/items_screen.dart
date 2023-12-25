import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_crud/models/item.dart';
import 'package:flutterfire_crud/widgets/recipe_card.dart';
import 'package:flutterfire_crud/screens/add_edit_item_screen.dart';
import 'package:flutterfire_crud/service/firestore_service.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Items'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEditScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: itemsCollection.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }
          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item != null) {
                final itemName = item['name'];
                final itemDescription = item['description'];
                final itemServes = item['serves'];
                final timestamp = item['timestamp'] as Timestamp?;
                if (timestamp != null) {
                  return RecipeCard(
                    item: Item(name: itemName, description: itemDescription, serves: itemServes, timestamp: timestamp),
                    myDateTime: timestamp.toDate(),
                  );
                }
              }
              // Return an empty container or other widget if item or timestamp is null
              return Container();
            },
          );
        },
      ),
    );
  }

  void _deleteItem(String itemId) async {
    await deleteItem(itemId);
  }
}