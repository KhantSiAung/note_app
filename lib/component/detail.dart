import 'package:flutter/material.dart';
import 'package:to_do_app/model/note_model.dart';
import 'package:to_do_app/screen/add_note_page.dart';
import 'package:to_do_app/service/databse_helper.dart';
import 'package:expendable_fab/expendable_fab.dart';

class DetailPage extends StatefulWidget {
  final Notes notes;

  const DetailPage({Key? key, required this.notes}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isDone = true;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notes> list = [];


  deleteNote(Notes notes)async{
    int id =0;
    id=databaseHelper.deleteNote(id) as int;
    return id;
  }

  updateNote(Notes notes) async {
    int id = 0;
    id = await databaseHelper.updateNote(notes);
    return id;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Your Detail",
              style: TextStyle(fontSize: 20,color: Colors.black),
            ),
            centerTitle: true,
            elevation: 1,
            backgroundColor: const Color(0xff8DCBE6)),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              SizedBox(
                  child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.notes.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              )),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.notes.body,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ExpendableFab(
          distance: 100,
          children: [
            ActionButton(onPressed: () { }, icon: const Icon(Icons.delete)),
            ActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddNotePage(
                              isEdit: true,
                              editnotes: widget.notes)))).then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.edit)),
          ],
        ));
  }
}
