import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_crud/models/item.dart';
import '../service/firestore_service.dart';

class UpdateItemScreen extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String itemDescription;
  final String itemServes;

  const UpdateItemScreen({
    Key? key,
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.itemServes,
  }) : super(key: key);

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final _uuidController = TextEditingController();
  final  _nameController = TextEditingController();
  final  _descriptionController = TextEditingController();
  final _servesController = TextEditingController();

  @override
  void initState() {
    _uuidController.text = widget.itemId;
    _nameController.text = widget.itemName;
    _descriptionController.text = widget.itemDescription;
    _servesController.text = widget.itemServes;
    super.initState();
  }

  void _updateItem(String itemId) {
    Timestamp timestampValue = Timestamp.now();
    Item updatedItem = Item(
      name: _nameController.text,
      description: _descriptionController.text,
      serves: _servesController.text,
      timestamp: timestampValue,
    );
    updateItem(itemId, updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _uuidController,
              decoration: const InputDecoration(labelText: 'UUID'),
              enabled: false,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _servesController,
              decoration: const InputDecoration(labelText: 'Serves'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateItem(widget.itemId);
                    Navigator.pop(context);
                  },
                  child: const Text('Update Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _uuidController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}