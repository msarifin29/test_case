// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:test_case/todo/todo_feature.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final inputController = TextEditingController();
  final isEmpty = ValueNotifier<bool>(false);

  Future<dynamic> onRefresh() async {
    context.read<FetchTodosBloc>().add(const AllTodo());
  }

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void fetchTodos() {
    context.read<FetchTodosBloc>().add(
          AllTodo(name: inputController.text.trim(), isFilter: true),
        );
  }

  Future<T> formDialog<T>(
      {required String title,
      required String desc,
      required int id,
      required bool isUpdate}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FormTodoWidget(
          title: title,
          desc: desc,
          id: id,
          isUpdate: isUpdate,
        );
      },
    );
  }

  Future<T> confirmRemoveDialog<T>(int id) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return DialogRemoveWidget(id: id, onRefresh: onRefresh);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(
              controller: inputController,
              onPressed: () {
                inputController.clear();
                FocusScope.of(context).unfocus();
                onRefresh();
              },
              onSubmitted: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).unfocus();
                } else {
                  fetchTodos();
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: BlocBuilder<FetchTodosBloc, FetchTodosState>(
                builder: (context, state) {
                  if (state is FetchTodosLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FetchTodosFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Something wrong'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              onRefresh();
                            },
                            child: const Text('Refresh')),
                      ],
                    );
                  } else if (state is FetchTodosSucccess) {
                    List<Map<String, dynamic>> data = state.todos.todos;
                    final td = TodosResponses.toListMap(data);

                    if (td.isEmpty && inputController.text.isNotEmpty) {
                      return Center(
                        child: Text(
                          'Not found with keyword *${inputController.text.trim()}*',
                        ),
                      );
                    } else if (td.isEmpty) {
                      return const Center(
                        child: Text('Todo is Empty'),
                      );
                    }
                    return ListView.builder(
                      itemCount: td.length,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            formDialog(
                              title: td[i].title,
                              desc: td[i].description,
                              id: td[i].id,
                              isUpdate: true,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: const BehindMotion(),
                                dismissible:
                                    DismissiblePane(onDismissed: () {}),
                                children: [
                                  SlidableAction(
                                    icon: Icons.delete,
                                    label: '',
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    onPressed: (context) {
                                      confirmRemoveDialog(td[i].id);
                                    },
                                  ),
                                ],
                              ),
                              child: CardTodoWidget(td: td[i]),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('New'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const FormTodoWidget();
            },
          );
        },
      ),
    );
  }
}
