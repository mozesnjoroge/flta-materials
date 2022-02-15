import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../components/components.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating; //whether the user isa creating or updating an item

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null), //assertion operations on cascading
        super(key: key);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                    _timeOfDay.hour, _timeOfDay.minute),
              );
              widget.isUpdating
                  ? widget.onUpdate(groceryItem)
                  : widget.onCreate(groceryItem);
            },
            icon: const Icon(Icons.check),
          ),
        ],
        title: Text(
          'GroceryItem',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(
              height: 10.0,
            ),
            builImportanceField(),
            const SizedBox(
              height: 10.0,
            ),
            buildDateField(context),
            const SizedBox(
              height: 10.0,
            ),
            buildTimeField(context),
            const SizedBox(
              height: 10.0,
            ),
            buildColorPicker(context),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            buildQuantityField(),
            const SizedBox(
              height: 10.0,
            ),
            GroceryTile(
              groceryItem: GroceryItem(
                id: 'preview mode',
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                    _timeOfDay.hour, _timeOfDay.minute),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'e.g Apples, Banana, 1 Bag of Salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        )
      ],
    );
  }

  Widget builImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
                selectedColor:
                    Colors.black, //TODO: Try applying the _currentColor
                onSelected: (selected) {
                  setState(() {
                    _importance = Importance.low;
                  });
                },
                label: Text(
                  'low',
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                selected: _importance == Importance.low),
            ChoiceChip(
                selectedColor:
                    Colors.black, //TODO: Try applying the _currentColor
                onSelected: (selected) {
                  setState(() {
                    _importance = Importance.medium;
                  });
                },
                label: Text(
                  'medium',
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                selected: _importance == Importance.medium),
            ChoiceChip(
                selectedColor:
                    Colors.black, //TODO: Try applying the _currentColor
                onSelected: (selected) {
                  setState(() {
                    _importance = Importance.high;
                  });
                },
                label: Text(
                  'high',
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                selected: _importance == Importance.high),
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            OutlinedButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text('${DateFormat('dd-MM-yyyy').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time Of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            OutlinedButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                setState(
                  () {
                    if (timeOfDay != null) {
                      _timeOfDay = timeOfDay;
                    }
                  },
                );
              },
            ),
          ],
        ),
        Text(_timeOfDay.format(context).toString()),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: _currentColor,
              height: 50.0,
              width: 10.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            )
          ],
        ),
        OutlinedButton(
          child: const Text('Select'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() {
                        _currentColor = color;
                      });
                    },
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
          label: _currentSliderValue.toInt().toString(),
          value: _currentSliderValue.toDouble(),
          onChanged: (sliderValue) {
            setState(
              () {
                _currentSliderValue = sliderValue.toInt();
              },
            );
          },
          activeColor: _currentColor,
          inactiveColor: _currentColor.withOpacity(0.5),
          divisions: 100,
          min: 0.0,
          max: 100.0,
        ),
      ],
    );
  }
}
