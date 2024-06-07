// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import 'package:test_case/todo/todo_feature.dart';

part 'fetch_todos_event.dart';
part 'fetch_todos_state.dart';

class FetchTodosBloc extends Bloc<FetchTodosEvent, FetchTodosState> {
  final TodoRepository repository;
  FetchTodosBloc({required this.repository}) : super(FetchTodosInitial()) {
    on<AllTodo>((event, emit) async {
      emit(FetchTodosLoading());
      try {
        if (event.isFilter) {
          final todos = await repository.filterTodos(
            FilterTodoParam(name: event.name),
          );
          emit(FetchTodosSucccess(todos: todos, input: event.name));
        } else {
          final todos = await repository.fetchTodos();
          emit(FetchTodosSucccess(todos: todos));
        }
      } catch (e) {
        if (e is SocketException) {
          emit(const FetchTodosFailure('No Internet Connection'));
          debugPrint('SocketException : ${e.toString()}');
        } else if (e is TimeoutException) {
          emit(const FetchTodosFailure('Request time out'));
          debugPrint('TimeoutException : ${e.toString()}');
        } else if (e is TypeError) {
          emit(const FetchTodosFailure('Parsing failed'));
          debugPrint("TypeError : ${e.toString()}");
        } else {
          emit(const FetchTodosFailure('Failed to create todo'));
          debugPrint(e.toString());
        }
      }
    });
  }
}
