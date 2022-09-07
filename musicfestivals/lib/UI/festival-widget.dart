import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/ui/create-edit-festival.dart';
import 'package:realm/realm.dart';
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateEditFestival(
                          oldFestival: widget.festivals[index])));
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Deleting ${widget.festivals[index].name}"),
                      content: Text(
                          "Are you sure you want to delete ${widget.festivals[index].name}?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No")),
                        TextButton(
                          onPressed: (() {
                            var realm = RepositoryProvider.of<Realm>(context);
                            realm.write(
                                () => realm.delete(widget.festivals[index]));
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
