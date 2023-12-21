import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/firestore_service.dart';
import 'package:flutterfire_crud/models/item.dart';
import 'package:uuid/uuid.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({Key? key,}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final String itemId = const Uuid().v1();
  final  _nameController = TextEditingController();
  final  _descriptionController = TextEditingController();
  final _servesController = TextEditingController();
  final ValueNotifier<DateTime> _dateTime = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  void _addItem() {
    Timestamp timestampValue = Timestamp.now();
    Item newItem = Item(name: _nameController.text, description: _descriptionController.text, serves: _servesController.text, timestamp: timestampValue);
    addItem(newItem);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime.value = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        actions: [
          IconButton(
            onPressed: _showDatePicker,
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('UUID: $itemId'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
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