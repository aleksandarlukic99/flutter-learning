import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich4/components/grocery_tile.dart';
import 'package:fooderlich4/models/grocery_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;
  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  }) : isUpdating = (originalItem != null);

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
  int _currentSlideValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSlideValue = originalItem.quantity;
      _importance = originalItem.importance;
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
                  quantity: _currentSlideValue,
                  date: DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _timeOfDay.hour,
                    _timeOfDay.minute,
                  ),
                );
                if (widget.isUpdating) {
                  widget.onUpdate(groceryItem);
                } else {
                  widget.onCreate(groceryItem);
                }
              },
              icon: const Icon(Icons.check))
        ],
        elevation: 0.0,
        title: Text(
          "Grocery Item",
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10),
            buildColorPicker(context),
            const SizedBox(height: 10),
            buildQuantityField(),
            GroceryTile(
                item: GroceryItem(
                    id: 'previewMode',
                    name: _name,
                    importance: _importance,
                    color: _currentColor,
                    quantity: _currentSlideValue,
                    date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                        _dueDate.hour, _dueDate.minute)))
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
          "Item name",
          style: GoogleFonts.lato(fontSize: 28),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Importance",
          style: GoogleFonts.lato(fontSize: 28),
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              label: const Text(
                "low",
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label: const Text(
                "medium",
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text(
                "high",
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
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
              "Date",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              child: const Text("Select"),
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
            )
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
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
              "Time of Day",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
              child: const Text("Select"),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(_timeOfDay.format(context))
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Color",
              style: GoogleFonts.lato(fontSize: 28),
            ),
          ],
        ),
        TextButton(
          child: const Text("Select"),
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
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Save"))
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Quantity",
              style: GoogleFonts.lato(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Text(
              _currentSlideValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          inactiveColor: _currentColor.withOpacity(0.3),
          activeColor: _currentColor,
          value: _currentSlideValue.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: _currentSlideValue.toInt().toString(),
          onChanged: (value) {
            setState(() {
              _currentSlideValue = value.toInt();
            });
          },
        )
      ],
    );
  }
}
