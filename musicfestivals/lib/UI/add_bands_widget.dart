import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicfestivals/index.dart';
import 'package:realm/realm.dart';

class AddBandWidget extends StatefulWidget {
  const AddBandWidget({Key? key}) : super(key: key);

  @override
  State<AddBandWidget> createState() => _AddBandWidgetState();
}

class _AddBandWidgetState extends State<AddBandWidget> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
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
        title: const Text("New Band"),
        actions: [
          IconButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  realm.write(() =>
                      realm.add(Band(Uuid.v4(), _textController.text, "rok")));
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: TextField(
        controller: _textController,
        decoration: const InputDecoration(hintText: "Add new band name"),
      ),
    );
  }
}
