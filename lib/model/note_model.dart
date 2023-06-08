
class Notes {
  int? id;
  String title;
  String body;
  String date;
  int color;

  Notes({this.id, required this.body, required this.date, required this.title,required this.color});

  Notes.fromMap(Map<String, dynamic> note)
      : id = note['id'],
        title = note["title"],
        body = note['body'],
        date = note['date'],
        color = note["color"];

  get status => null; 



  Map<String, Object?> toMap() {
    return {"id": id, 'title': title, 'body': body, "date": date,"color":color};
  }
}
