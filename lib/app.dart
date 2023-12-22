import 'package:flutter/material.dart';
import 'package:flutterfire_crud/screens/items_screen.dart';
import 'package:flutterfire_crud/theme/bens_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = BensTheme.light();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fire CRUD',
      theme: theme,
      home: const ItemsScreen(),
    );
  }
}