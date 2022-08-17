import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'band_id': bandId,
      'firstname': firstName,
      'lastname': lastName,
      'nickname': nickName
    };
  }

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'start_date': startDate,
      'ticket_price': ticketPrice,
      'location': location
    };
  }

  @override
  String toString() {
    return "Music festival -> id: $id, name: $name, description: $description, start_date: $startDate, ticket_price: $ticketPrice, location: $location}";
  }

  @override
  bool operator ==(covariant DatabaseMusicFestival other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
