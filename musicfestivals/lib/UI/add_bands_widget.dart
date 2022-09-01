import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/index.dart';
import 'package:realm/realm.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddBandWidget extends StatefulWidget {
  const AddBandWidget({Key? key}) : super(key: key);

  @override
  State<AddBandWidget> createState() => _AddBandWidgetState();
}

class _AddBandWidgetState extends State<AddBandWidget> {
  late final TextEditingController _textController;
  List<Song> selectedSongs = [];

  @override
  void initState() {
    _textController = TextEditingController();
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
    var songs = realm.all<Song>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Band"),
        actions: [
          IconButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  realm.write(() => realm.add(Band(
                      Uuid.v4(), _textController.text, "rok",
                      songs: selectedSongs)));
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "Add new band name"),
          ),
          MultiSelectDialogField<Song>(
            title: const Text("Songs"),
            items:
                songs.map((song) => MultiSelectItem(song, song.name)).toList(),
            buttonText: const Text("Select songs"),
            buttonIcon: const Icon(Icons.expand_more),
            searchable: true,
            selectedColor: Colors.blue,
            checkColor: Colors.white,
            listType: MultiSelectListType.LIST,
            onConfirm: (values) {
              selectedSongs = values;
            },
          )
        ],
      ),
    );
  }
}
