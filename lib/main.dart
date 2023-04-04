import 'package:flutter/material.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/screen/poducts_screen.dart';

class Todo {
  String title;
  bool completed;
  String description;

  Todo(
      {required this.title,
      required this.completed,
      required this.description});
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> todos = [];
  final TextEditingController _valueInput1 = TextEditingController();
  final TextEditingController _valueInput2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                setState(() {
                  todo.completed = value!;
                });
              },
            ),
            title: Text(todo.title),
            subtitle: Text(todo.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          // content: TextField(
          //   controller: valueInput,
          //   decoration: const InputDecoration(hintText: 'Todo title'),
          // ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _valueInput1,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: _valueInput2,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  final todo = Todo(
                      title: _valueInput1.text,
                      completed: false,
                      description: _valueInput2.text);
                  todos.add(todo);
                  _valueInput1.clear();
                  _valueInput2.clear();
                  Navigator.pop(context);
                })
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // title: 'Todo App',
    // home: TodoApp(),
    //title: 'Call Api',
    //home: HomeScreen(),
    home: ProductsHome(),
  ));
}
