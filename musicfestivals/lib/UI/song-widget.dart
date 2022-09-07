import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/ui/create-edit-song.dart';
import 'package:realm/realm.dart';
import '../data/db/database.dart';

class SongWidget extends StatefulWidget {
  const SongWidget({Key? key, required this.songs}) : super(key: key);
  final List<Song> songs;
  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.songs.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(widget.songs[index].name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateEditSong(
                            oldSong: widget.songs[index],
                          )));
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Deleting ${widget.songs[index].name}"),
                      content: Text(
                          "Are you sure you want to delete ${widget.songs[index].name}?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No")),
                        TextButton(
                          onPressed: (() {
                            var realm = RepositoryProvider.of<Realm>(context);
                            realm
                                .write(() => realm.delete(widget.songs[index]));
                            Navigator.pop(context);
                          }),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
