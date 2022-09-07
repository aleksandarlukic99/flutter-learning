import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/ui/create-edit-bands-widget.dart';
import 'package:musicfestivals/ui/create-edit-festival.dart';
import 'package:musicfestivals/ui/create-edit-song.dart';
import 'package:realm/realm.dart';
import '../data/db/database.dart';

//funkcije koje vracaju wigete treba pretvoriti u widgete. Ako ima puno takvih funkcija uticu na performanse.
class FabWidget extends StatefulWidget {
  const FabWidget({
    Key? key,
    required this.indexTab,
  }) : super(key: key);

  final int indexTab;

  @override
  State<FabWidget> createState() => _FabWidgetState();
}

class _FabWidgetState extends State<FabWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (widget.indexTab == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEditFestival(oldFestival: null),
              ));
        } else if (widget.indexTab == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateEditBandWidget(oldBand: null)));
        } else if (widget.indexTab == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateEditSong(oldSong: null)));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
