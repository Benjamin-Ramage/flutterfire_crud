import 'package:flutter/material.dart';
import '../service/firestore_service.dart';
import 'package:flutterfire_crud/models/item.dart';

class UpdateItem extends StatefulWidget {
  final String itemId;

  const UpdateItem({Key? key, required this.itemId}) : super(key: key);

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final _uuidController = TextEditingController();
  final  _nameController = TextEditingController();
  final  _descriptionController = TextEditingController();

  @override
  void initState() {
    _uuidController.text = widget.itemId;
    super.initState();
  }

  void _updateItem(String itemId) {
    Item updatedItem = Item(name: _nameController.text, description: _descriptionController.text);
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