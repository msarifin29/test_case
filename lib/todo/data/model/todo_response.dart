// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class TodoResponse extends Equatable {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  const TodoResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, title, description, createdAt];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt,
    };
  }

  factory TodoResponse.fromMap(Map<String, dynamic> map) {
    return TodoResponse(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: map['created_at'] as String,
    );
  }
}

class TodosResponses extends Equatable {
  final List<Map<String, dynamic>> todos;
  const TodosResponses({required this.todos});

  List<TodoResponse> fromListMap(todos) {
    return todos.map<TodoResponse>((e) {
      return TodoResponse(
        id: e['id'] as int,
        title: e['title'] as String,
        description: e['description'] as String,
        createdAt: e['created_at'] as String,
      );
    }).toList();
  }

  static List<TodoResponse> toListMap(todos) {
    return todos.map<TodoResponse>((e) {
      return TodoResponse(
        id: e['id'] as int,
        title: e['title'] as String,
        description: e['description'] as String,
        createdAt: e['created_at'] as String,
      );
    }).toList();
  }

  @override
  List<Object?> get props => [todos];
}
