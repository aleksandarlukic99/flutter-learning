import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/index.dart';
import 'package:realm/realm.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CreateEditBandWidget extends StatefulWidget {
  const CreateEditBandWidget({Key? key, required this.oldBand})
      : super(key: key);
  final Band? oldBand;

  @override
  State<CreateEditBandWidget> createState() => _CreateEditBandWidgetState();
}

class _CreateEditBandWidgetState extends State<CreateEditBandWidget> {
  late final TextEditingController _textController;
  List<Song> selectedSongs = [];

  @override
  void initState() {
    _textController = TextEditingController();
    if (widget.oldBand != null) {
      _textController.text = widget.oldBand!.name;
      selectedSongs = widget.oldBand!.songs;
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
    var songs = realm.all<Song>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add/edit band"),
        actions: [
          IconButton(
              onPressed: () {
                var band = Band(Uuid.v4(), _textController.text, "rok",
                    songs: selectedSongs);
                if (_textController.text.isNotEmpty && widget.oldBand == null) {
                  realm.write(() => realm.add(band));
                  Navigator.pop(context);
                } else if (_textController.text.isNotEmpty &&
                    widget.oldBand != null) {
                  realm.write(() {
                    widget.oldBand!.name = _textController.text;
                    widget.oldBand!.songs.clear();
                    widget.oldBand!.songs.addAll(selectedSongs);
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
                hintText: "Add new band name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
            child: MultiSelectDialogField<Song>(
              title: const Text("Songs"),
              items: songs
                  .map((song) => MultiSelectItem(song, song.name))
                  .toList(),
              buttonText: const Text("Select songs"),
              searchHint: "Choose song(s)",
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
                selectedSongs = values;
              },
              initialValue: widget.oldBand != null ? widget.oldBand!.songs : [],
            ),
          )
        ],
      ),
    );
  }
}
