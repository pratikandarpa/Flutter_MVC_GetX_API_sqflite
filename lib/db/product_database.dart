// ignore_for_file: unnecessary_new, unused_field, avoid_print, prefer_const_declarations, unused_local_variable

import 'package:flutter_mvc_api_getx_sqllite/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final id = 'INTEGER NOT NULL';
    final title = 'TEXT NOT NULL';
    final price = 'DOUBLE NOT NULL';
    final image = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $amazonCart ( 
  ${ProductFields.id} $id,
  ${ProductFields.title} $title,
  ${ProductFields.price} $price,
  ${ProductFields.image} $image
  )
''');
  }

  Future create(Welcome welcome) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    await db.insert(amazonCart, welcome.toJson());
    print(welcome.id);
  }

  Future<List<Welcome>> readAllNotes() async {
    final db = await instance.database;
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(amazonCart);
    print(result);
    return result.map((json) => Welcome.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      amazonCart,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Welcome> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      amazonCart,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Welcome.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
}
