import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/component/edit_text_form.dart';
import 'package:to_do_app/model/note_model.dart';
import 'package:to_do_app/screen/notes_screen.dart';
import 'package:to_do_app/service/databse_helper.dart';

// ignore: must_be_immutable
class AddNotePage extends StatefulWidget {
  bool isEdit;
  final Notes? editnotes;
  AddNotePage({Key? key, required this.isEdit, this.editnotes})
      : super(key: key);

  @override
  State<AddNotePage> createState() => _NwNotePageState();
}

class _NwNotePageState extends State<AddNotePage> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd ");
  int selectIndex = 0;
  Color _backgroundcolor = const Color(0xffB6EAFA);
  List<Color> colorChoice = const [
    Color(0xffF7DB6A),
    Color(0xffD864A9),
    Color(0xffE11299),
    Color(0xffFE6244),
    Color(0xff245953),
    Color(0xff867070),
    Color(0xff4D4D4D),
    Color(0xffEA5455),
    Color(0xff146C94),
    Color(0xffE21818),
    Color(0xff98DFD6),
    Color(0xff8F43EE),
    Color(0xff539165),
    Color(0xffE7B10A),
    Color(0xff16FF00),
  ];
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  addNote() {
    databaseHelper.insertNote(Notes(
        body: bodyController.text,
        date: dateFormat.format(DateTime.now()),
        title: titleController.text,
        color: _backgroundcolor.value));
  }

  updateNote() {
    databaseHelper.updateNote(Notes(
        body: bodyController.text,
        date: dateFormat.format(DateTime.now()),
        title: titleController.text,
        color: _backgroundcolor.value));
  }

  @override
  void initState() {
    titleController.text = widget.editnotes?.title ?? "";
    bodyController.text = widget.editnotes?.body ?? "";
    super.initState();
  }

  update(Notes notes) async {
    await databaseHelper.updateNote(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff8DCBE6),
          elevation: 0,
          title: const Text(
            "Add Note",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 70, child: colorList()),
            EditTextForm(
                controller: titleController,
               backgroundcolor:_backgroundcolor ,
                hintText: "Text",
                title: "Title"),
            SizedBox(
              child: EditTextForm(
                  controller: bodyController,
                  backgroundcolor: Color(0xffF1F6F9),
                  hintText: "Note",
                  title: "Body"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff19A7CE),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit == true) {
                update(
                  Notes(
                      id: widget.editnotes!.id,
                      title: titleController.text,
                      body: bodyController.text,
                      color: _backgroundcolor.value,
                      date: dateFormat.format(DateTime.now())),
                );

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const NotesScreenPage())),
                    (route) => false);
              } else {
                widget.isEdit = false;
                addNote();
                Navigator.pop(context);
              }
            }
          },
          child: Icon(widget.isEdit ? Icons.add : Icons.edit),
        ),
      ),
    );
  }

  Widget colorList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colorChoice.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _backgroundcolor = colorChoice[index];
                selectIndex = index;
                print(_backgroundcolor.value);
              });
            },
            child: CircleAvatar(
              backgroundColor: colorChoice[index],
              radius: selectIndex == index ? 40 : 20,
            ),
          ),
        );
      },
    );
  }
}
