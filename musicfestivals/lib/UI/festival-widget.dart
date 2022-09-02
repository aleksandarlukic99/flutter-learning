import 'package:flutter/material.dart';
import '../data/db/database.dart';

class FestivalWidget extends StatefulWidget {
  const FestivalWidget({Key? key, required this.festivals}) : super(key: key);
  final List<Festival> festivals;

  @override
  State<FestivalWidget> createState() => _FestivalWidgetState();
}

class _FestivalWidgetState extends State<FestivalWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.festivals.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(widget.festivals[index].name),
          ),
        );
      },
    );
  }
}
