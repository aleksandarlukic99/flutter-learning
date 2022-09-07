import 'package:realm/realm.dart';
import 'package:musicfestivals/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CreateEditSong extends StatefulWidget {
  const CreateEditSong({super.key, required this.oldSong});
  final Song? oldSong;

  @override
  State<CreateEditSong> createState() => _CreateEditSongState();
}

class _CreateEditSongState extends State<CreateEditSong> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    if (widget.oldSong != null) {
      _textController.text = widget.oldSong!.name;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add/edit song"),
        actions: [
          IconButton(
              onPressed: () {
                var song = Song(Uuid.v4(), _textController.text);
                if (_textController.text.isNotEmpty && widget.oldSong == null) {
                  realm.write(() => realm.add(song));
                  Navigator.pop(context);
                } else if (_textController.text.isNotEmpty &&
                    widget.oldSong != null) {
                  realm
                      .write(() => widget.oldSong!.name = _textController.text);
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
                  hintText: "Add song name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            ),
          )
        ],
      ),
    );
  }
}
