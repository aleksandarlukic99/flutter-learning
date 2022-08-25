import 'package:realm/realm.dart';


//to generate code run 'flutter pub run realm generate'
part 'database.g.dart';


@RealmModel()
class _Festival{

  @PrimaryKey()
  late Uuid id;
  late String name;
  late List<_Band> bands;

}

@RealmModel()
class _Member{

  @PrimaryKey()
  late Uuid id;
  late String firstName;
  late String lastName;
  late _Band? band;
}

@RealmModel()
class _Song{

  @PrimaryKey()
  late Uuid id;
  late _Band? band;
  late String name;

}

@RealmModel()
class _Band{

  @PrimaryKey()
  late Uuid id;
  late String name;
  late String musicType;
  late List<_Song> songs;
  late List<_Member> members;

}