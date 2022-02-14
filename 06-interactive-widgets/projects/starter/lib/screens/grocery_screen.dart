import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
//TODO: Present GroceryItemScreen
          final groceryManager =
              Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  groceryManager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {
                  // groceryManager.updateItem(item, index)
                },
              ),
            ),
          );
        },
      ),
      body: buildGroceryScreen(),
    );
  }
}

Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(builder: (context, groceryManager, child) {
    if (groceryManager.groceryItems.isNotEmpty) {
      return Container();
      //TODO : Add grocery List Screen
    } else {
      return const EmptyGroceryScreen();
    }
  });
}
