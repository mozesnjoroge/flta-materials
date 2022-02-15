import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager groceryManager;
  const GroceryListScreen({Key? key, required this.groceryManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = groceryManager.groceryItems;

    return ListView.separated(
        itemBuilder: ((context, index) {
          final groceryItem = groceryItems[index];
          return GroceryTile(
            key: Key(groceryItem.id),
            groceryItem: groceryItem,
            onComplete: (change) {
              if (change != null) {
                groceryManager.itemOnComplete(index, change);
              }
            },
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16.0,
          );
        },
        itemCount: groceryItems.length);
  }
}
