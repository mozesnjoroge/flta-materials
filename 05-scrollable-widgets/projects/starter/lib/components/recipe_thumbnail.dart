import 'package:flutter/material.dart';

import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({Key? key, required this.simpleRecipe})
      : super(key: key);

  final SimpleRecipe simpleRecipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child:
                  Image.asset('${simpleRecipe.dishImage}', fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${simpleRecipe.title}',
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '${simpleRecipe.duration}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
