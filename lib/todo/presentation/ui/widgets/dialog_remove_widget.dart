import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_case/todo/todo_feature.dart';

class DialogRemoveWidget extends StatelessWidget {
  const DialogRemoveWidget({
    super.key,
    required this.id,
    required this.onRefresh,
  });
  final int id;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure remove ?'),
            const SizedBox(height: 20),
            BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is RemoveTodoSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Success remove todo'),
                    ),
                  );
                } else if (state is RemoveTodoFailure) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something wrong'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RemoveTodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(OnRemove(id: id));
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
