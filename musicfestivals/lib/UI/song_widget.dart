import 'package:flutter/material.dart';
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
          ),
        );
      },
    );
  }
}
