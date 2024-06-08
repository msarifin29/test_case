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

  Future<dynamic> onRefresh() async {
    context.read<FetchTodosBloc>().add(const AllTodo());
  }

  @override
  void initState() {
    // onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await onRefresh();
          return Future.delayed(const Duration(milliseconds: 500));
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).unfocus();
                      } else {
                        context.read<FetchTodosBloc>().add(AllTodo(
                              name: inputController.text.trim(),
                              isFilter: true,
                            ));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: BlocBuilder<FetchTodosBloc, FetchTodosState>(
                    builder: (context, state) {
                      if (state is FetchTodosLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchTodosFailure) {
                        return const Text('Something wrong');
                      } else if (state is FetchTodosSucccess) {
                        List<Map<String, dynamic>> data = state.todos.todos;
                        final td = TodosResponses.toListMap(data);
                        return ListView.builder(
                            itemCount: td.length,
                            itemBuilder: (ctx, i) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return FormTodoWidget(
                                        title: td[i].title,
                                        desc: td[i].description,
                                        id: td[i].id,
                                        isUpdate: true,
                                      );
                                    },
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
                                          foregroundColor: Colors.red,
                                          onPressed: (context) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const Text(
                                                              'Are you sure remove ?'),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          BlocConsumer<
                                                              CreateTodoBloc,
                                                              CreateTodoState>(
                                                            listener: (context,
                                                                state) {
                                                              if (state
                                                                  is RemoveTodoSuccess) {
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Success remove todo',
                                                                    ),
                                                                  ),
                                                                );
                                                              } else if (state
                                                                  is RemoveTodoFailure) {
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Failed remove todo',
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is RemoveTodoLoading) {
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'No',
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              CreateTodoBloc>()
                                                                          .add(
                                                                            OnRemove(
                                                                              id: td[i].id,
                                                                            ),
                                                                          );
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Yes',
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 3,
                                      ),
                                      child: BlocConsumer<CreateTodoBloc,
                                          CreateTodoState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  td[i].title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                td[i].description.isEmpty
                                                    ? const SizedBox()
                                                    : Text(td[i].description),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
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
              ).then((value) => onRefresh());
            },
          ),
        ),
      ),
    );
  }
}
