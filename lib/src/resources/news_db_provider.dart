import 'package:http/http.dart';
import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:news/src/models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;
  NewsDbProvider() {
    init();
  }
  Future<void> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute('''CREATE TABLE Items(
        id INTEGER PRIMARY KEY,
        type TEXT,
        by TEXT,
        time INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER.
        title TEXT,
        descendants INTEGER
      )''');
    });
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db
        .query('Items', columns: null, where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      return null;
    }
    var list = [];
    for (var map in maps) {
      list.add(ItemModel.fromDb(map));
    }
    return list.first;
  }

  @override
  Future<int> addItem(ItemModel itemModel) {
    return db.insert('Items', itemModel.toMapForDb(itemModel));
  }

  @override
  Future<List<int>> fetchTopIds() async {
    return [];
  }
}

final newsDbProvider = NewsDbProvider();
