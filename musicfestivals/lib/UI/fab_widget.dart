import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/UI/add_bands_widget.dart';
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
    var realm = RepositoryProvider.of<Realm>(context);
    return FloatingActionButton(
      onPressed: () async {
        if (widget.indexTab == 0) {
          print("First button");
        } else if (widget.indexTab == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBandWidget()));
        } else if (widget.indexTab == 2) {
          var r = Random();
          var index = r.nextInt(10000);
          realm.write(() => realm.add(Song(Uuid.v4(), "Pesma $index")));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
