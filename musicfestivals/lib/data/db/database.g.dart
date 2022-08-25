// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Festival extends _Festival with RealmEntity, RealmObject {
  Festival(
    Uuid id,
    String name, {
    Iterable<Band> bands = const [],
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set<RealmList<Band>>(this, 'bands', RealmList<Band>(bands));
  }

  Festival._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  RealmList<Band> get bands =>
      RealmObject.get<Band>(this, 'bands') as RealmList<Band>;
  @override
  set bands(covariant RealmList<Band> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Festival>> get changes =>
      RealmObject.getChanges<Festival>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Festival._);
    return const SchemaObject(Festival, 'Festival', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('bands', RealmPropertyType.object,
          linkTarget: 'Band', collectionType: RealmCollectionType.list),
    ]);
  }
}

class Member extends _Member with RealmEntity, RealmObject {
  Member(
    Uuid id,
    String firstName,
    String lastName, {
    Band? band,
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'firstName', firstName);
    RealmObject.set(this, 'lastName', lastName);
    RealmObject.set(this, 'band', band);
  }

  Member._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  String get firstName => RealmObject.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObject.set(this, 'firstName', value);

  @override
  String get lastName => RealmObject.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObject.set(this, 'lastName', value);

  @override
  Band? get band => RealmObject.get<Band>(this, 'band') as Band?;
  @override
  set band(covariant Band? value) => RealmObject.set(this, 'band', value);

  @override
  Stream<RealmObjectChanges<Member>> get changes =>
      RealmObject.getChanges<Member>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Member._);
    return const SchemaObject(Member, 'Member', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('band', RealmPropertyType.object,
          optional: true, linkTarget: 'Band'),
    ]);
  }
}

class Song extends _Song with RealmEntity, RealmObject {
  Song(
    Uuid id,
    String name, {
    Band? band,
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'band', band);
    RealmObject.set(this, 'name', name);
  }

  Song._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  Band? get band => RealmObject.get<Band>(this, 'band') as Band?;
  @override
  set band(covariant Band? value) => RealmObject.set(this, 'band', value);

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Song>> get changes =>
      RealmObject.getChanges<Song>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Song._);
    return const SchemaObject(Song, 'Song', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('band', RealmPropertyType.object,
          optional: true, linkTarget: 'Band'),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class Band extends _Band with RealmEntity, RealmObject {
  Band(
    Uuid id,
    String name,
    String musicType, {
    Iterable<Song> songs = const [],
    Iterable<Member> members = const [],
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'musicType', musicType);
    RealmObject.set<RealmList<Song>>(this, 'songs', RealmList<Song>(songs));
    RealmObject.set<RealmList<Member>>(
        this, 'members', RealmList<Member>(members));
  }

  Band._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String get musicType => RealmObject.get<String>(this, 'musicType') as String;
  @override
  set musicType(String value) => RealmObject.set(this, 'musicType', value);

  @override
  RealmList<Song> get songs =>
      RealmObject.get<Song>(this, 'songs') as RealmList<Song>;
  @override
  set songs(covariant RealmList<Song> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Member> get members =>
      RealmObject.get<Member>(this, 'members') as RealmList<Member>;
  @override
  set members(covariant RealmList<Member> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Band>> get changes =>
      RealmObject.getChanges<Band>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Band._);
    return const SchemaObject(Band, 'Band', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('musicType', RealmPropertyType.string),
      SchemaProperty('songs', RealmPropertyType.object,
          linkTarget: 'Song', collectionType: RealmCollectionType.list),
      SchemaProperty('members', RealmPropertyType.object,
          linkTarget: 'Member', collectionType: RealmCollectionType.list),
    ]);
  }
}
