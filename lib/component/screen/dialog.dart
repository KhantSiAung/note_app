import 'package:flutter/material.dart';
import 'package:to_do_app/model/note_model.dart';
import 'package:to_do_app/screen/notes_screen.dart';
import '../../service/databse_helper.dart';

class MyAlertBox {
  static Future<void> myAlertDialgoBox(
      {required BuildContext context, required int id}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Notes> list = [];
    Future<List<Notes>> noteDelete(int id) async {
      await databaseHelper.deleteNote(id);
      return list;
    }

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "Are you sure delete?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                          noteDelete(id);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesScreenPage()),
                          (route) => false);
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }
}
