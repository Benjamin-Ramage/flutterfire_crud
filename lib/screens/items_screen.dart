import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_crud/screens/edit_item.dart';
import 'package:flutterfire_crud/services/firestore_service.dart';

class ItemsScreen extends StatelessWidget {

  void _deleteItem(String itemId) async {
   await deleteItem(itemId);
  }

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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditItem(itemId: '', itemName: '', itemDescription: '',)));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: itemsCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            final items = snapshot.data!.docs;
            return ListView(
              scrollDirection: Axis.vertical,
              children: items.map((item) {
                final itemId = item.id;
                final itemData = item.data();
                final itemName = itemData['name'];
                final itemDescription = itemData['description'];
                return ListTile(
                  title: Text(itemName),
                  subtitle: Text(itemDescription),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditItem(
                              itemId: itemId,
                              itemName: itemName,
                              itemDescription: itemDescription,
                             ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => _deleteItem(itemId),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}