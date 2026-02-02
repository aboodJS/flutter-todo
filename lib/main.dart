import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();
  List<String> todos = [""];

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(controller: myController),
                ),
                IconButton.filled(onPressed: addtask, icon: Icon(Icons.send)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                prototypeItem: ListTile(title: Text(todos.first)),
                itemBuilder: (context, index) {
                  return ListTile(title: Text(todos[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
