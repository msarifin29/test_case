// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_case/todo/todo_feature.dart';

class FormTodoWidget extends StatefulWidget {
  const FormTodoWidget({
    super.key,
    this.title = '',
    this.desc = '',
    this.id = 0,
    this.isUpdate = false,
  });

  final String title;
  final String desc;
  final int id;
  final bool isUpdate;

  @override
  State<FormTodoWidget> createState() => _FormTodoWidgetState();
}

class _FormTodoWidgetState extends State<FormTodoWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    descController.text = widget.desc;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Title'),
            const SizedBox(height: 10),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value == "") {
                  return 'Title can\'t be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text('Description'),
            const SizedBox(height: 10),
            TextFormField(
              controller: descController,
              maxLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            widget.isUpdate
                ? BlocConsumer<CreateTodoBloc, CreateTodoState>(
                    listener: (context, state) {
                      debugPrint('kambing $state');
                      if (state is UpdateTodoSuccess) {
                        Navigator.pop(context);
                      } else if (state is UpdateTodoFailure) {}
                    },
                    builder: (context, state) {
                      if (state is UpdateTodoLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (widget.title == titleController.text.trim() &&
                                widget.desc == descController.text.trim()) {
                              Navigator.pop(context);
                            } else {
                              context.read<CreateTodoBloc>().add(OnUpdate(
                                  title: titleController.text.trim(),
                                  description: descController.text.trim(),
                                  id: widget.id));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          minimumSize: Size(
                            MediaQuery.sizeOf(context).width,
                            45,
                          ),
                        ),
                        child: const Text('Submit'),
                      );
                    },
                  )
                : BlocConsumer<CreateTodoBloc, CreateTodoState>(
                    listener: (context, state) {
                      if (state is CreateTodoSuccess) {
                        Navigator.pop(context);
                      } else if (state is CreateTodoFailure) {}
                    },
                    builder: (context, state) {
                      if (state is CreateTodoLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreateTodoBloc>().add(
                                  OnCreated(
                                    titleController.text.trim(),
                                    descController.text.trim(),
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          minimumSize: Size(
                            MediaQuery.sizeOf(context).width,
                            45,
                          ),
                        ),
                        child: const Text('Submit'),
                      );
                    },
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
