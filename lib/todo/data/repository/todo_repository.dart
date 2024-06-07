// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:test_case/todo/todo_feature.dart';

abstract class TodoRepository {
  Future<bool> createTodo(CreateTodoParams params);
  Future<TodosResponses> fetchTodos();
  Future<bool> updateTodo(UpdateTodoParams params, int id);
  Future<TodosResponses> filterTodos(FilterTodoParam param);
}

class TodoRepositoryImpl extends TodoRepository {
  final TodoRemoteDatasource datasource;
  TodoRepositoryImpl({required this.datasource});

  @override
  Future<bool> createTodo(CreateTodoParams params) async {
    return await datasource.createTodo(params);
  }

  @override
  Future<TodosResponses> fetchTodos() async {
    return await datasource.fetchTodos();
  }

  @override
  Future<bool> updateTodo(UpdateTodoParams params, int id) async {
    return await datasource.updateTodo(params, id);
  }

  @override
  Future<TodosResponses> filterTodos(FilterTodoParam param) async {
    return await datasource.filterTodos(param);
  }
}
