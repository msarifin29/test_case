// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:test_case/todo/todo_feature.dart';

abstract class TodoRemoteDatasource {
  Future<bool> createTodo(CreateTodoParams params);
  Future<TodosResponses> fetchTodos();
  Future<bool> updateTodo(UpdateTodoParams params, int id);
  Future<TodosResponses> filterTodos(FilterTodoParam param);
  Future<bool> removeTodo(RemoveTodoParam param);
}

class TodoRemoteDatasourceImpl extends TodoRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Future<bool> createTodo(CreateTodoParams params) async {
    try {
      await supabase.from('todos').insert(params.toMap());
      return true;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<TodosResponses> fetchTodos() async {
    try {
      final todos = await supabase.from('todos').select();
      return TodosResponses(todos: todos);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<bool> updateTodo(UpdateTodoParams params, int id) async {
    try {
      await supabase.from('todos').update(params.toMap()).eq('id', id);
      return true;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<TodosResponses> filterTodos(FilterTodoParam param) async {
    try {
      final todos = await supabase
          .from('todos')
          .select()
          .ilike('title', '%${param.name}%');
      return TodosResponses(todos: todos);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<bool> removeTodo(RemoveTodoParam param) async {
    try {
      await supabase.from('todos').delete().eq('id', param.id);
      return true;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }
}

class CreateTodoParams extends Equatable {
  final String title;
  final String description;
  const CreateTodoParams({required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'description': description};
  }

  @override
  List<Object?> get props => [title, description];
}

class UpdateTodoParams extends Equatable {
  final String? title;
  final String? description;
  const UpdateTodoParams({this.title, this.description});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    return data;
  }

  @override
  List<Object?> get props => [title, description];
}

class FilterTodoParam extends Equatable {
  final String name;
  const FilterTodoParam({required this.name});
  @override
  List<Object?> get props => [name];
}

class RemoveTodoParam extends Equatable {
  final int id;
  const RemoveTodoParam({required this.id});
  @override
  List<Object?> get props => [id];
}
