import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:musicfestivals/data/db/database.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class CreateEditFestival extends StatefulWidget {
  const CreateEditFestival({super.key, required this.oldFestival});
  final Festival? oldFestival;

  @override
  State<CreateEditFestival> createState() => _CreateEditFestivalState();
}

class _CreateEditFestivalState extends State<CreateEditFestival> {
  late final TextEditingController _textController;
  List<Band> selectedBands = [];

  @override
  void initState() {
    _textController = TextEditingController();
    if (widget.oldFestival != null) {
      _textController.text = widget.oldFestival!.name;
      selectedBands = widget.oldFestival!.bands;
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var realm = RepositoryProvider.of<Realm>(context);
    var bands = realm.all<Band>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add/edit festival"),
        actions: [
          IconButton(
              onPressed: () {
                var festival = Festival(Uuid.v4(), _textController.text,
                    bands: selectedBands);
                if (_textController.text.isNotEmpty &&
                    widget.oldFestival == null) {
                  realm.write(() => realm.add(festival));
                  Navigator.pop(context);
                } else if (_textController.text.isNotEmpty &&
                    widget.oldFestival != null) {
                  realm.write(() {
                    widget.oldFestival!.name = _textController.text;
                    widget.oldFestival!.bands.clear();
                    widget.oldFestival!.bands.addAll(selectedBands);
                  });
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: "Add new festival name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: MultiSelectDialogField<Band>(
              title: const Text("Bands"),
              items: bands
                  .map((band) => MultiSelectItem(band, band.name))
                  .toList(),
              buttonText: const Text("Select bands"),
              searchHint: "Choose band(s)",
              buttonIcon: const Icon(Icons.expand_more),
              searchable: true,
              selectedColor: Colors.blue,
              checkColor: Colors.white,
              listType: MultiSelectListType.LIST,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(color: Colors.black, width: 1.0)),
              onConfirm: (values) {
                selectedBands = values;
              },
              initialValue:
                  widget.oldFestival != null ? widget.oldFestival!.bands : [],
            ),
          )
        ],
      ),
    );
  }
}
