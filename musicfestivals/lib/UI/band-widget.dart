import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/ui/create-edit-bands-widget.dart';
import 'package:realm/realm.dart';
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateEditBandWidget(
                            oldBand: widget.bands[index],
                          )));
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Deleting ${widget.bands[index].name}"),
                      content: Text(
                          "Are you sure you want to delete ${widget.bands[index].name}?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No")),
                        TextButton(
                          onPressed: (() {
                            var realm = RepositoryProvider.of<Realm>(context);
                            realm
                                .write(() => realm.delete(widget.bands[index]));
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
