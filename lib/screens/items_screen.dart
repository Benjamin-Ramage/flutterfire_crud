import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_crud/screens/update_item_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutterfire_crud/screens/add_item_screen.dart';
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddItemScreen()));
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

          return ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item != null) {
                final itemId = item.id;
                final itemName = item['name'];
                final itemDescription = item['description'];
                final itemServes = item['serves'];
                final timestamp = item['timestamp'] as Timestamp?;
                if (timestamp != null) {
                  final formattedDateTime = _formatDateTime(timestamp.toDate());
                  return ListTile(
                      key: ValueKey(itemId),
                      leading: Text(itemServes),
                      title: Text(itemName, style: Theme.of(context).textTheme.bodyText1,),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemDescription),
                          Text('Date: $formattedDateTime'),
                        ],
                      ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateItemScreen(
                                  itemId: itemId,
                                  itemName: itemName,
                                  itemDescription: itemDescription,
                                  itemServes: itemServes,
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

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('MMM d, y');
    return formatter.format(dateTime);
  }

  void _deleteItem(String itemId) async {
    await deleteItem(itemId);
  }
}