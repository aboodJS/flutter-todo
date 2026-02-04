import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
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
                IconButton.filled(onPressed: addtask, icon: Icon(Icons.send)),
              ],
            ),
            todos.length > 0
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
