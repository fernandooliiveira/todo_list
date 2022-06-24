import 'package:flutter/material.dart';

import '../widgets/todo.list.item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List<String> todos = [];
  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma Tarefa",
                          hintText: "Ex: Estudar Flutter"),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(todoController.text.isNotEmpty){
                        setState((){
                          todos.add(todoController.text);
                          todoController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14.0),
                      primary: const Color(0xFF00D7F3),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for(String todo in todos)
                      TodoListItem(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Text("Você possui 0 tarefas pendentes"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14.0),
                      primary: const Color(0xFF00D7F3),
                    ),
                    child: const Text("Limpar Tudo"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
