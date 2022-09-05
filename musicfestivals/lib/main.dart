import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'ui/band-widget.dart';
import 'ui/fab-widget.dart';
import 'ui/festival-widget.dart';
import 'ui/song-widget.dart';
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
  late StreamSubscription<RealmResultsChanges<Song>> _songsSubscription;
  late StreamSubscription<RealmResultsChanges<Band>> _bandSubscription;
  late StreamSubscription<RealmResultsChanges<Festival>> _festivalSubscription;
  List<Song> _songs = List.empty();
  List<Band> _bands = List.empty();
  List<Festival> _festivals = List.empty();
  var indexTab = 0;

  @override
  void dispose() {
    super.dispose();
    _songsSubscription.cancel();
    _bandSubscription.cancel();
    _festivalSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    var realm = RepositoryProvider.of<Realm>(context);
    RealmResults<Song> realmSongs = realm.all<Song>();
    _songs = realmSongs.toList();

    _songsSubscription = realmSongs.changes.listen((changes) {
      setState(() {
        _songs = changes.results.toList();
        changes.inserted;
        changes.modified;
        changes.deleted;
        changes.newModified;
        changes.moved;
      });
    });

    RealmResults<Band> realmBands = realm.all<Band>();
    _bands = realmBands.toList();

    _bandSubscription = realmBands.changes.listen((changes) {
      setState(() {
        _bands = changes.results.toList();
        changes.inserted;
        changes.modified;
        changes.deleted;
        changes.newModified;
        changes.moved;
      });
    });

    RealmResults<Festival> realmFestival = realm.all<Festival>();
    _festivals = realmFestival.toList();

    _festivalSubscription = realmFestival.changes.listen((changes) {
      setState(() {
        _festivals = changes.results.toList();
        changes.inserted;
        changes.modified;
        changes.deleted;
        changes.newModified;
        changes.moved;
      });
    });
  }

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
              body: TabBarView(
                children: [
                  FestivalWidget(festivals: _festivals),
                  BandWidget(bands: _bands),
                  SongWidget(songs: _songs),
                ],
              ),
              floatingActionButton: FabWidget(indexTab: indexTab))),
    );
  }
}
