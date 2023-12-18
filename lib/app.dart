import 'package:flutter/material.dart';
import 'package:flutterfire_crud/screens/items_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fire CRUD',
      home: ItemsScreen(),
    );
  }
}