

class Todo {
  String title;
  DateTime dateTime;

  Todo({
    required this.title,
    required this.dateTime,
  });

  Todo.fromJson(Map<String, dynamic> json) :
        title = json['title'],
        dateTime = DateTime.parse(json['datetime']);


  String dateTimeBr() {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}";
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime.toIso8601String()
    };
  }


}
