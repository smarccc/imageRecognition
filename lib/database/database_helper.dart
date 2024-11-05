import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'plants.db');

    // Check if the database needs to be copied from assets
    if (await _needsDatabaseUpdate(path)) {
      await _copyDatabaseFromAssets(path);
    }

    return await openDatabase(path);
  }

  Future<bool> _needsDatabaseUpdate(String path) async {
    // Logic to determine if the database needs to be updated
    // For simplicity, we'll copy the database every time the app starts
    return true;
  }

  Future<void> _copyDatabaseFromAssets(String path) async {
    // Delete existing database if it exists
    if (FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound) {
      await File(path).delete();
    }

    // Copy the database from assets
    ByteData data = await rootBundle.load('assets/database/plants.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  Future<List<Map<String, dynamic>>> getPlants() async {
    final db = await database;
    return await db.query('plants');
  }
}
