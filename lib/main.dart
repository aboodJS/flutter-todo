import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> args) async {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  var db = await openDatabase('tasks.db');
  runApp(MyApp());
}

void saveData() async {
  await openDatabase('tasks.db');
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'tasks.db');
  Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT)',
      );
    },
  );
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
      'INSERT INTO tasks(name, value, num) VALUES("buy milk")',
    );
    print('inserted1: $id1');
  });

  List<Map> list = await database.rawQuery('SELECT * FROM tasks');
  print(list);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();
  List<String> todos = [];

  void addtask() {
    final text = myController.text;
    setState(() {
      todos.add(text);
    });
    print(todos);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Todo"), backgroundColor: Colors.blue),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(controller: myController),
                ),
                IconButton.filled(onPressed: saveData, icon: Icon(Icons.send)),
              ],
            ),
            todos.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: todos.length,
                      prototypeItem: ListTile(title: Text(todos.first)),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            textAlign: TextAlign.center,
                            todos[index],
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(child: Center(child: Text("start adding tasks"))),

            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => print("add tasks"),
                    icon: Icon(Icons.add_task_outlined),
                    tooltip: "add tasks",
                  ),
                  IconButton(
                    onPressed: () => print("Complete Tasks"),
                    icon: Icon(Icons.check_circle_outline),
                    tooltip: "finised tasks",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
