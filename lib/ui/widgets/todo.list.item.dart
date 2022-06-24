import 'package:flutter/material.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({Key? key}) : super(key: key);

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "20/11/2015",
            style: TextStyle(
              fontSize: 12
            ),
          ),
          Text(
            "Tarefa 123",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
