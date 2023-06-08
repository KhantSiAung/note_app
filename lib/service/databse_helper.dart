import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model/note_model.dart';

class DatabaseHelper {
  String dataBaseName = 'notes_table';
  String id = "id";
  String title = 'title';
  String body = 'body';
  String date = "date";
  String color = "color";

  Future<Database> initialDB() async {
    String path = await getDatabasesPath();
    return openDatabase(path + "notes.db", onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $dataBaseName($id  INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT NOT NULL , $body TEXT NOT NULL,$date TEXT NOT NULL,$color INTEGER NOT NULL)');
    }, version: 1);
  }

  Future<int> insertNote(Notes notes) async {
    //data input
    print("Insert color");
    print(notes.color);
    final Database db = await initialDB();
    int id = await db.insert(
      dataBaseName,
      notes.toMap(),
    );
    return id;
  }

  Future<List<Notes>> retriveNotes() async {
    //data output
    final Database db = await initialDB();
    final List<Map<String, Object?>> queryResult = await db.query(dataBaseName);
    List<Notes> allNotes = queryResult.map((e) => Notes.fromMap(e)).toList();
    print(allNotes[0].color);
    return allNotes;
  }

  Future<void> deleteNote(int id) async {
    final Database db = await initialDB();
    await db.delete(
      dataBaseName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<int>updateNote(Notes notes)async{
    final Database db = await initialDB();
    final int result = await db.update(dataBaseName, notes.toMap(),
    where: "$id=?",
    whereArgs: [notes.id]);
    return result;
  }
}