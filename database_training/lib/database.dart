import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        '''CREATE TABLE "dogs" (
	"id"	INTEGER,
	"name"	TEXT,
	"age"	INTEGER,
	PRIMARY KEY("id")
);''',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final db = await database;
    //This ConflitAlgorithm replaces data
    db.insert('doggie_database.db', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  var ari = const Dog(id: 0, name: 'Ari', age: 5);
  var zuca = const Dog(id: 1, name: 'Zuca', age: 6);
  await insertDog(ari);
  await insertDog(zuca);

  //print all dogs
  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) {
      return Dog(
          id: maps[index]['id'],
          name: maps[index]['name'],
          age: maps[index]['age']);
    });
  }

  print(await dogs());

  Future<void> updateDog(Dog dog) async {
    final db = await database;

    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  zuca = Dog(id: zuca.id, name: zuca.name, age: zuca.age + 2);

  print(await dogs());

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
