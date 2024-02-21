import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_feature/Favourite.dart';
import 'AnimeResponseModel.dart';
import 'package:path/path.dart';

class ControllerListAnime extends ChangeNotifier{
  late List<Favourite> favourite;
  List<Anime> animemodelctr = <Anime>[];
  List<Favourite> favData = <Favourite>[];
  bool isLoading = true;

  ControllerListAnime() {
    loadData();
    database();
  }

  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion ,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Favourite ( id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, image BLOB )');
  }


  Future<void> geFav() async {
    final data = await _database!.query("Favourite");
    favData = data.map((e) => Favourite.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> insert(Map<String, dynamic> row) async {
    await _database!.insert("Favourite", row);

    geFav();
  }

  Future delete(String idParam) async {
    await _database!.delete("Favourite", where: 'title = ?', whereArgs: [idParam]);
    geFav();
  }

  loadData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://anime-api.xyz/page-5"));

      if (response.statusCode == 200) {
        //OK
        //mengisi data productResponseModelCtr dengan hasil json dari model
        animemodelctr =
            animeFromJson(response.body);
      } else {
        print("status code : ${response.statusCode}");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error : $e");
    }
  }
}

