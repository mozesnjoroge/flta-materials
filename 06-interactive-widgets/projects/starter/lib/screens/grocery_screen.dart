import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: buildGroceryScreen(),
    );
  }
}

Widget buildGroceryScreen() {
  return Consumer<GrooceryManager>(builder: (context, groceryManager, child) {
    if (groceryManager.groceryItems.isNotEmpty) {
      return Container();
      //TODO : Add grocery List Screen
    } else {
      return const EmptyGroceryScreen();
    }
  });
}
