import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class EditItem extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String itemDescription;

  const EditItem({super.key, required this.itemId, required this.itemName, required this.itemDescription});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.itemName;
    _descriptionController.text = widget.itemDescription;
    super.initState();
  }

  void _addItem() {
    addItem(_nameController.text, _descriptionController.text);
    _nameController.clear();
    _descriptionController.clear();
  }

  void _updateItem(String itemId) {
    updateItem(itemId, _nameController.text, _descriptionController.text);
    _nameController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
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
                const SizedBox(width: 10),
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
}