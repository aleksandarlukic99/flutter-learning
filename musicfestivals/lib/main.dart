import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'index.dart';

void main() {
  var config = Configuration.local(
      [Festival.schema, Band.schema, Member.schema, Song.schema],
      initialDataCallback: (realm) {
    var s1 = realm.add(Song(Uuid.v4(), "Pesma1"));
    var s2 = realm.add(Song(Uuid.v4(), "Pesma2"));
    var s3 = realm.add(Song(Uuid.v4(), "Pesma3"));
    var s4 = realm.add(Song(Uuid.v4(), "Pesma4"));
    var s5 = realm.add(Song(Uuid.v4(), "Pesma5"));
    var s6 = realm.add(Song(Uuid.v4(), "Pesma6"));
    var s7 = realm.add(Song(Uuid.v4(), "Pesma7"));
    var s8 = realm.add(Song(Uuid.v4(), "Pesma8"));
    var s9 = realm.add(Song(Uuid.v4(), "Pesma9"));
    var s10 = realm.add(Song(Uuid.v4(), "Pesma10"));
    var s11 = realm.add(Song(Uuid.v4(), "Pesma11"));
    var s12 = realm.add(Song(Uuid.v4(), "Pesma12"));

    var m1 = realm.add(Member(Uuid.v4(), "Pera1", "Peric1"));
    var m2 = realm.add(Member(Uuid.v4(), "Pera2", "Peric2"));
    var m3 = realm.add(Member(Uuid.v4(), "Pera3", "Peric3"));

    var b1 = realm.add(Band(Uuid.v4(), "Bend 1", "Tip 1",
        members: [m1, m2, m3], songs: [s1, s2, s3]));
    var b2 = realm.add(Band(Uuid.v4(), "Bend 2", "Tip 2", songs: [s4, s5]));
    var b3 = realm.add(Band(Uuid.v4(), "Bend 3", "Tip 3", songs: [s6, s7]));

    realm.add(Festival(Uuid.v4(), "Festival 1", bands: [b1, b2]));
    realm.add(Festival(Uuid.v4(), "Festival 2", bands: [b3]));
  });
  Realm realm = Realm(config);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Realm>(
          create: (context) {
            return realm;
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Music festival',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initDatabase();
  }

  void initDatabase() {
    var realm = RepositoryProvider.of<Realm>(context);
    var results = realm.all<Band>();
    for (var value in results) {
      print(value.name);
    }

    var results2 = realm.all<Member>();
    for (var value in results2) {
      print("${value.firstName} ${value.lastName}");
    }

    var results3 = realm.all<Song>();
    for (var value in results3) {
      print(value.name);
    }

    var results4 = realm.all<Festival>();
    for (var value in results4) {
      print(value.name);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  var indexTab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                bottom: TabBar(
                    onTap: (index) {
                      setState(() {
                        indexTab = index;
                      });
                    },
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.library_music_rounded),
                        text: "Festival",
                      ),
                      Tab(
                        icon: Icon(Icons.people),
                        text: "Band",
                      ),
                      Tab(
                        icon: Icon(Icons.music_note),
                        text: "Song",
                      ),
                    ]),
              ),
              body: const TabBarView(
                children: [
                  FestivalWidget(),
                  BandWidget(),
                  SongWidget(),
                ],
              ),
              floatingActionButton: _bottomButtons())),
    );
  }

  Widget _bottomButtons() {
    var realm = RepositoryProvider.of<Realm>(context);
    if (indexTab == 0) {
      return FloatingActionButton(
        onPressed: () {
          print("First button");
        },
        child: const Icon(Icons.add),
      );
    } else if (indexTab == 1) {
      return FloatingActionButton(
        onPressed: () {
          print("Second button");
        },
        child: const Icon(Icons.add),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {
          setState(() {
            realm.write(() => realm.add(Song(Uuid.v4(), "Pesma99")));
            final songs = realm.all<Song>();
            songs.changes.listen((changes) {
              changes.inserted;
              changes.modified;
              changes.deleted;
              changes.newModified;
              changes.moved;
              changes.results;
            });
          });
        },
        child: const Icon(Icons.add),
      );
    }
  }
}

class FestivalWidget extends StatefulWidget {
  const FestivalWidget({Key? key}) : super(key: key);

  @override
  State<FestivalWidget> createState() => _FestivalWidgetState();
}

class _FestivalWidgetState extends State<FestivalWidget> {
  @override
  Widget build(BuildContext context) {
    var realm = RepositoryProvider.of<Realm>(context);
    var festivals = realm.all<Festival>();
    return ListView.builder(
      itemCount: festivals.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(festivals[index].name),
          ),
        );
      },
    );
  }
}

class BandWidget extends StatefulWidget {
  const BandWidget({Key? key}) : super(key: key);

  @override
  State<BandWidget> createState() => _BandWidgetState();
}

class _BandWidgetState extends State<BandWidget> {
  @override
  Widget build(BuildContext context) {
    var realm = RepositoryProvider.of<Realm>(context);
    var bands = realm.all<Band>();
    return ListView.builder(
      itemCount: bands.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(bands[index].name),
          ),
        );
      },
    );
  }
}

class SongWidget extends StatefulWidget {
  const SongWidget({Key? key}) : super(key: key);

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    var realm = RepositoryProvider.of<Realm>(context);
    var songs = realm.all<Song>();
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(songs[index].name),
          ),
        );
      },
    );
  }
}
