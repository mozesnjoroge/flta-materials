import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/recipe_grid_view.dart';
import '../models/models.dart';

class RecipeScreen extends StatelessWidget {
  final exploreRecipeService = MockFooderlichService();

  RecipeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: exploreRecipeService.getRecipes(),
        builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: RecipeGridView(
                simpleRecipes: snapshot.data ?? [],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
        });
  }
}
