import 'package:flutter/material.dart';
import 'package:task_list/models/todo.dart';
import 'package:task_list/repositories/todo_repository.dart';

import '../widgets/todo.list.item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? positionDeletedTodo;
  final TodoRepository todoRepository = TodoRepository();

  final TextEditingController todoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoLit().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                            hintText: "Ex: Arrumar Chuveiro",
                            focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Color(0xFF00D7F3),
                                 width: 2
                               )
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (todoController.text.isNotEmpty) {
                            setState(() {
                              todos.add(Todo(
                                  title: todoController.text,
                                  dateTime: DateTime.now()));
                              todoController.clear();
                            });
                            todoRepository.saveTodoList(todos);
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
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            onDelete: onDelete,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Você possui ${todos.length} tarefas pendentes",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: showDeleteTodosConfirmationDialog,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(14.0),
                            primary: const Color(0xFF00D7F3),
                          ),
                          child: const Text("Limpar Tudo"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    positionDeletedTodo = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarefa ${todo.title} foi removida com sucesso!"),
        backgroundColor: const Color(0xFF00D7F3),
        action: SnackBarAction(
          onPressed: () {
            setState(() {
              todos.insert(positionDeletedTodo!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
          label: 'Desfazer',
          textColor: Colors.white,
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar tudo ?"),
        content:
            const Text("Você tem certeza que deseja apagar todas as tarefas ?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                todos.clear();
              });
              todoRepository.saveTodoList(todos);
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF00D7F3),
            ),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}
