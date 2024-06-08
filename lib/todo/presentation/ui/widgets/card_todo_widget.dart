import 'package:flutter/material.dart';
import 'package:test_case/todo/todo_feature.dart';

class CardTodoWidget extends StatelessWidget {
  const CardTodoWidget({super.key, required this.td});

  final TodoResponse td;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              td.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            td.description.isEmpty ? const SizedBox() : Text(td.description),
          ],
        ),
      ),
    );
  }
}
