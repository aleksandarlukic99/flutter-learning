import 'package:flutter/material.dart';
import '../data/db/database.dart';

class BandWidget extends StatefulWidget {
  const BandWidget({Key? key, required this.bands}) : super(key: key);
  final List<Band> bands;

  @override
  State<BandWidget> createState() => _BandWidgetState();
}

class _BandWidgetState extends State<BandWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.bands.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(widget.bands[index].name),
          ),
        );
      },
    );
  }
}
