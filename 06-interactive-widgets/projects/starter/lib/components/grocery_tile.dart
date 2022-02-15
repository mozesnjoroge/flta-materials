import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class GroceryTile extends StatelessWidget {
  final GroceryItem groceryItem;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;
  GroceryTile({Key? key, required this.groceryItem, this.onComplete})
      : textDecoration = groceryItem.isComplete
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5.0,
                color: groceryItem.color,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    groceryItem.name.toString(),
                    style: GoogleFonts.lato(
                        decoration: textDecoration,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  buildDate(),
                  const SizedBox(
                    height: 4.0,
                  ),
                  buildImportance(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                groceryItem.quantity.toString(),
                style: GoogleFonts.lato(
                    fontSize: 21.0, decoration: textDecoration),
              ),
              buildCheckbox(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildImportance() {
    if (groceryItem.importance == Importance.low) {
      return Text(
        'Low',
        style: GoogleFonts.lato(decoration: textDecoration),
      );
    } else if (groceryItem.importance == Importance.medium) {
      return Text(
        'Medium',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else if (groceryItem.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w900,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('Importance type does not exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(groceryItem.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(value: groceryItem.isComplete, onChanged: onComplete);
  }
}
