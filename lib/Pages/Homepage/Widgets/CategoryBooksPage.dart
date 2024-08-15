import 'package:flutter/material.dart';

class CategoryBooksPage extends StatelessWidget {
  final String category;
  const CategoryBooksPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Example: You can fetch and display books based on the category here
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('Books for $category category'),
      ),
    );
  }
}
