import 'package:flutter/material.dart';

import 'models.dart';

class GrooceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void itemOnComplete(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
