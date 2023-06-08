import 'package:flutter/material.dart';
import 'package:to_do_app/component/detail.dart';
import 'package:to_do_app/component/screen/dialog.dart';
import 'package:to_do_app/screen/add_note_page.dart';
import 'package:to_do_app/model/note_model.dart';
import 'package:to_do_app/service/databse_helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesScreenPage extends StatefulWidget {
  const NotesScreenPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NotesScreenPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd ");
  List<Notes> notesList = [
    Notes(body: "body", date: "date", title: "title", color: 345243542)
  ];
  Notes? notes;
  @override
  void initState() {
    retrieveNotes();
    super.initState();
  }

  retrieveNotes() async {
    List<Notes> retrievedNotes = await databaseHelper.retriveNotes();
    setState(() {
      notesList = retrievedNotes;
    });
    print(notesList.length);
    return notesList;
  }

  int crossAxisCount = 2;
  bool axisCount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff8DCBE6),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  axisCount = !axisCount;
                  print(axisCount);
                });
              },
              icon: Icon(axisCount ? Icons.reorder : Icons.grid_view))
        ],
        title: const Text(
          "You Notes",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          child: MasonryGridView.count(
              scrollDirection: Axis.vertical,
              itemCount: notesList.length,
              crossAxisCount: axisCount ? 1 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemBuilder: (context, index) {
                if (notesList.isEmpty) {
                  return const Text("There is no data Here!");
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                DetailPage(notes: notesList[index]))));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(notesList[index].color),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notesList[index].title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await MyAlertBox.myAlertDialgoBox(
                                      context: context,
                                      id: notesList[index].id ?? 0);
                                },
                                icon:const Icon(
                                  Icons.delete,
                                  
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            notesList[index].body,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range,
                                  color: Colors.black54, size: 16),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                notesList[index].date.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff19A7CE),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: ((context) => AddNotePage(
                        editnotes: notes,
                        isEdit: false,
                      ))))
              .then((value) {
            setState(() {
              retrieveNotes();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
