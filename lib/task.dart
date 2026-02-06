const String tabelName = 'tasks';

const String idField = "_id";
const String titleField = "title";

const List<String> taskColumns = [idField, titleField];

const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const String titleType = "TEXT NOT NULL";

class Task {
  final int? id;
  final String? title;

  Task(this.title, this.id);
}
