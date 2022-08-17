import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'database_exceptions.dart';

class DatabaseService {
  Database? _db;

  Future<DatabaseMusicFestival> createFestival() async {
    final db = _getDatabaseOrThrow();
  }

  Future<void> deleteFestival(int id) async {
    final db = _getDatabaseOrThrow();
    await db.delete('music_festival', where: 'id = ?', whereArgs: [id]);
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, 'musicfestival.db');
      final db = await openDatabase(dbPath);
      _db = db;

      //create music festival table
      await db.execute(createMusicFestivalTable);

      //create song table
      await db.execute(createSongTable);

      //create band table
      await db.execute(createBandTable);

      //create member table
      await db.execute(createMemberTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

class DatabaseMember {
  final int id;
  final int bandId;
  final String firstName;
  final String lastName;
  final String nickName;

  DatabaseMember(
      {required this.id,
      required this.bandId,
      required this.firstName,
      required this.lastName,
      required this.nickName});

  DatabaseMember.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        bandId = map['band_id'] as int,
        firstName = map['firstname'] as String,
        lastName = map['lastname'] as String,
        nickName = map['nickname'] as String;

  @override
  String toString() {
    return "Member -> id: $id, band_id: $bandId, firstname: $firstName, lastname: $lastName, nickname: $nickName";
  }

  @override
  bool operator ==(covariant DatabaseMember other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseSong {
  final int id;
  final int bandId;
  final String name;

  DatabaseSong({required this.id, required this.bandId, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'band_id': bandId,
      'name': name,
    };
  }

  DatabaseSong.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        bandId = map['band_id'] as int,
        name = map['name'] as String;

  @override
  String toString() {
    return "Song -> id: $id, band_id: $bandId, name: $name";
  }

  @override
  bool operator ==(covariant DatabaseSong other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseBand {
  final int id;
  final int musicFestivalId;
  final String name;
  final String genre;

  DatabaseBand(
      {required this.id,
      required this.musicFestivalId,
      required this.name,
      required this.genre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'music_festival_id': musicFestivalId,
      'name': name,
      'genre': genre
    };
  }

  DatabaseBand.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        musicFestivalId = map['music_festival_id'] as int,
        name = map['name'] as String,
        genre = map['genre'] as String;

  @override
  String toString() {
    return "Band -> id: $id, music_festival_id: $musicFestivalId, name: $name, genre: $genre";
  }

  @override
  bool operator ==(covariant DatabaseBand other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabaseMusicFestival {
  final int id;
  final String name;
  final String description;
  final String startDate;
  final int ticketPrice;
  final String location;

  DatabaseMusicFestival(
      {required this.id,
      required this.name,
      required this.description,
      required this.startDate,
      required this.ticketPrice,
      required this.location});

  DatabaseMusicFestival.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        description = map['description'] as String,
        startDate = map['start_date'] as String,
        ticketPrice = map['ticket_price'] as int,
        location = map['location'] as String;

  @override
  String toString() {
    return "Music festival -> id: $id, name: $name, description: $description, start_date: $startDate, ticket_price: $ticketPrice, location: $location}";
  }

  @override
  bool operator ==(covariant DatabaseMusicFestival other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const createBandTable = """CREATE TABLE "band" (
	"id"	INTEGER NOT NULL,
	"music_festival_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"genre"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("music_festival_id") REFERENCES "music_festival"("id")
);
""";

const createMemberTable = """CREATE TABLE "member" (
	"id"	INTEGER NOT NULL,
	"band_id"	INTEGER NOT NULL,
	"firstname"	TEXT NOT NULL,
	"lastname"	TEXT NOT NULL,
	"nickname"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("band_id") REFERENCES "band"("id")
);
""";

const createMusicFestivalTable = """CREATE TABLE "music_festival" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"description"	TEXT NOT NULL,
	"start_date"	TEXT NOT NULL,
	"ticket_price"	INTEGER NOT NULL,
	"location"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";

const createSongTable = """CREATE TABLE "song" (
	"id"	INTEGER NOT NULL,
	"band_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("band_id") REFERENCES "band"("id")
);
""";
