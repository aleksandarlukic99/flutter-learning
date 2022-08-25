
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

import 'index.dart';

void main() {
  var config = Configuration.local([Festival.schema, Band.schema, Member.schema, Song.schema],
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
      
      var b1 = realm.add(Band(Uuid.v4(), "Bend 1", "Tip 1", members: [m1, m2, m3], songs: [s1, s2, s3]));
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
