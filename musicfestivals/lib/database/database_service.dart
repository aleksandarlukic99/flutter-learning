import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'database_exceptions.dart';

class DatabaseService {
  Database? _db;

  Future<DatabaseSong> createSong(DatabaseSong song) async {
    final db = _getDatabaseOrThrow();
    int id = await db.insert("song", {
      'band_id': song.bandId,
      'name': song.name,
    });
    return DatabaseSong(id: id, bandId: song.bandId, name: song.name);
  }

  Future<DatabaseSong> updateSong(DatabaseSong song) async {
    final db = _getDatabaseOrThrow();
    db.update(
        "song",
        {
          'band_id': song.bandId,
          'name': song.name,
        },
        where: "id = ?",
        whereArgs: [song.id]);

    return DatabaseSong(id: song.id, bandId: song.bandId, name: song.name);
  }

  Future<List<DatabaseSong>> getAllSongs() async {
    final db = _getDatabaseOrThrow();
    List<Map<String, Object?>> songs = await db.query(
      "song",
      columns: ["id", "band_id", "name"],
    );

    return songs
        .map((song) => DatabaseSong(
            id: song['id'] as int,
            bandId: song['band_id'] as int,
            name: song['name'] as String))
        .toList();
  }

  Future<DatabaseSong?> getSongById(int id) async {
    final db = _getDatabaseOrThrow();
    var queryResult = await db.query(
      "song",
      columns: ["id", "band_id", "name"],
      where: "id=?",
      whereArgs: [id],
    );
    if (queryResult.isEmpty) {
      return null;
    }
    Map<String, Object?> song = queryResult.first;
    return DatabaseSong(
        id: song['id'] as int,
        bandId: song["band_id"] as int,
        name: song['name'] as String);
  }

  Future<DatabaseBand> createBand(DatabaseBand band) async {
    final db = _getDatabaseOrThrow();
    int id = await db.insert("band", {
      'music_festival_id': band.musicFestivalId,
      'name': band.name,
      'genre': band.genre
    });
    return DatabaseBand(
        id: id,
        musicFestivalId: band.musicFestivalId,
        name: band.name,
        genre: band.genre);
  }

  Future<DatabaseBand> updateBand(DatabaseBand band) async {
    final db = _getDatabaseOrThrow();
    db.update(
        "band",
        {
          'music_festival_id': band.musicFestivalId,
          'name': band.name,
          'genre': band.genre
        },
        where: "id = ?",
        whereArgs: [band.id]);

    return DatabaseBand(
        id: band.id,
        musicFestivalId: band.musicFestivalId,
        name: band.name,
        genre: band.genre);
  }

  Future<List<DatabaseBand>> getAllBands() async {
    final db = _getDatabaseOrThrow();
    List<Map<String, Object?>> bands = await db.query(
      "band",
      columns: ["id", "music_festival_id", "name", "genre"],
    );
    return bands
        .map((band) => DatabaseBand(
            id: band['id'] as int,
            musicFestivalId: band["music_festival_id"] as int,
            name: band['name'] as String,
            genre: band['genre'] as String))
        .toList();
  }

  Future<DatabaseBand?> getBandById(int id) async {
    final db = _getDatabaseOrThrow();
    var queryResult = await db.query(
      "band",
      columns: ["id", "music_festival_id", "name", "genre"],
      where: "id=?",
      whereArgs: [id],
    );
    if (queryResult.isEmpty) {
      return null;
    }
    Map<String, Object?> band = queryResult.first;
    return DatabaseBand(
        id: band['id'] as int,
        musicFestivalId: band["music_festival_id"] as int,
        name: band['name'] as String,
        genre: band['genre'] as String);
  }

  Future<DatabaseMusicFestival> createMusicFestival(
      DatabaseMusicFestival festival) async {
    final db = _getDatabaseOrThrow();
    int id = await db.insert("music_festival", {
      "name": festival.name,
      "description": festival.description,
      "start_date": festival.startDate,
      "ticket_price": festival.ticketPrice,
      "location": festival.location
    });
    return DatabaseMusicFestival(
        id: id,
        name: festival.name,
        description: festival.description,
        startDate: festival.startDate,
        ticketPrice: festival.ticketPrice,
        location: festival.location);
  }

  Future<DatabaseMusicFestival> updateFestival(
      DatabaseMusicFestival festival) async {
    final db = _getDatabaseOrThrow();
    db.update(
        "music_festival",
        {
          "name": festival.name,
          "description": festival.description,
          "start_date": festival.startDate,
          "ticket_price": festival.ticketPrice,
          "location": festival.location
        },
        where: "id = ?",
        whereArgs: [festival.id]);

    return DatabaseMusicFestival(
        id: festival.id,
        name: festival.name,
        description: festival.description,
        startDate: festival.startDate,
        ticketPrice: festival.ticketPrice,
        location: festival.location);
  }

  Future<List<DatabaseMusicFestival>> getAllFestivals() async {
    final db = _getDatabaseOrThrow();
    List<Map<String, Object?>> festivals = await db.query(
      "music_festival",
      columns: [
        "id",
        "name",
        "description",
        "start_date",
        "ticket_price",
        "location",
      ],
    );

    return festivals
        .map((festival) => DatabaseMusicFestival(
            id: festival["id"] as int,
            name: festival["name"] as String,
            description: festival['description'] as String,
            startDate: festival["start_date"] as String,
            ticketPrice: festival["ticket_price"] as int,
            location: festival["location"] as String))
        .toList();
  }

  Future<DatabaseMusicFestival?> getFestivalById(int id) async {
    final db = _getDatabaseOrThrow();
    var queryResult = await db.query(
      "music_festival",
      columns: [
        "id",
        "name",
        "description",
        "start_date",
        "ticket_price",
        "location"
      ],
      where: "id=?",
      whereArgs: [id],
    );
    if (queryResult.isEmpty) {
      return null;
    }
    Map<String, Object?> festival = queryResult.first;
    return DatabaseMusicFestival(
        id: festival['id'] as int,
        name: festival['name'] as String,
        description: festival['description'] as String,
        startDate: festival["start_date"] as String,
        ticketPrice: festival["ticket_price"] as int,
        location: festival['location'] as String);
  }

  Future<DatabaseMember> createMember(DatabaseMember member) async {
    final db = _getDatabaseOrThrow();
    int id = await db.insert("member", {
      "band_id": member.bandId,
      "firstname": member.firstName,
      "lastname": member.lastName,
      "nickname": member.nickName,
    });
    return DatabaseMember(
        id: id,
        bandId: member.bandId,
        firstName: member.firstName,
        lastName: member.lastName,
        nickName: member.nickName);
  }

  Future<DatabaseMember> updateMember(DatabaseMember member) async {
    final db = _getDatabaseOrThrow();
    db.update(
        "member",
        {
          "band_id": member.bandId,
          "firstname": member.firstName,
          "lastname": member.lastName,
          "nickname": member.nickName,
        },
        where: "id = ?",
        whereArgs: [member.id]);

    return DatabaseMember(
        id: member.id,
        bandId: member.bandId,
        firstName: member.firstName,
        lastName: member.lastName,
        nickName: member.nickName);
  }

  Future<List<DatabaseMember>> getAllMembers() async {
    final db = _getDatabaseOrThrow();
    List<Map<String, Object?>> members = await db.query(
      "member",
      columns: [
        "id",
        "band_id",
        "firstname",
        "lastname",
        "nickname",
      ],
    );

    return members
        .map((member) => DatabaseMember(
            id: member["id"] as int,
            bandId: member["band_id"] as int,
            firstName: member["firstname"] as String,
            lastName: member["lastname"] as String,
            nickName: member["nickname"] as String))
        .toList();
  }

  Future<DatabaseMember?> getMemberById(int id) async {
    final db = _getDatabaseOrThrow();
    var queryResult = await db.query(
      "member",
      columns: [
        "id",
        "band_id",
        "firstname",
        "lastname",
        "nickname",
      ],
      where: "id=?",
      whereArgs: [id],
    );
    if (queryResult.isEmpty) {
      return null;
    }
    Map<String, Object?> member = queryResult.first;
    return DatabaseMember(
        id: member["id"] as int,
        bandId: member["band_id"] as int,
        firstName: member["firstname"] as String,
        lastName: member["lastname"] as String,
        nickName: member["nickname"] as String);
  }

  Future<void> deleteSong(int id) async {
    final db = _getDatabaseOrThrow();
    await db.delete('song', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteBand(int id) async {
    final db = _getDatabaseOrThrow();
    await db.delete('band', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteMember(int id) async {
    final db = _getDatabaseOrThrow();
    await db.delete('member', where: 'id = ?', whereArgs: [id]);
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

  Future<int> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, 'musicfestival.db');
      final db = await openDatabase(dbPath);
      _db = db;

      if (await databaseExists((dbPath))) {
        return 1;
      }

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

    return -1;
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

const createBand2FestivaAssignement = """CREATE TABLE "band_to_festival" (
 "id" INTEGER NOT NULL,
 "music_festival_id"  INTEGER NOT NULL,
 "band_id"  INTEGER NOT NULL,
 PRIMARY KEY("id" AUTOINCREMENT),
 FOREIGN KEY("music_festival_id") REFERENCES "music_festival"("id")
 FOREIGN KEY("band_id") REFERENCES "band"("id")
);
""";
