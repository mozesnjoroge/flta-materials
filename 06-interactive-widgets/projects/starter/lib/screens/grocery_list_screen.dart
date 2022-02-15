import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

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
          return Dismissible(
            key: Key(groceryItem.id),
            direction: DismissDirection.startToEnd,
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: const Icon(Icons.delete_forever,
                  color: Colors.white, size: 50.0),
            ),
            onDismissed: (direction) {
              groceryManager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${groceryItem.name} dismissed'),
                ),
              );
            },
            child: InkWell(
              child: GroceryTile(
                key: Key(groceryItem.id),
                groceryItem: groceryItem,
                //TODO Wrap ina Dismissable

                onComplete: (change) {
                  if (change != null) {
                    groceryManager.itemOnComplete(index, change);
                  }
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                        onCreate: (groceryItem) {},
                        onUpdate: (groceryItem) {
                          groceryManager.updateItem(groceryItem, index);
                          Navigator.pop(context);
                        }),
                  ),
                );
              },
            ),
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
