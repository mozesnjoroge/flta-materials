import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({Key? key, required this.simpleRecipes})
      : super(key: key);
  final List<SimpleRecipe> simpleRecipes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: GridView.builder(
        itemCount: simpleRecipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return RecipeThumbnail(simpleRecipe: simpleRecipes[index]);
        },
      ),
    );
  }
}
