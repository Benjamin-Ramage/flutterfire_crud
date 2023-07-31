import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddItem extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String itemDescription;

  const AddItem({super.key, required this.itemId, required this.itemName, required this.itemDescription});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final  _nameController = TextEditingController();
  final  _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.itemName;
    _descriptionController.text = widget.itemDescription;
    super.initState();
  }

  void _addItem() {
    addItem(_nameController.text, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addItem();
                    Navigator.pop(context);
                  },
                  child: const Text('Add Item'),
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
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}