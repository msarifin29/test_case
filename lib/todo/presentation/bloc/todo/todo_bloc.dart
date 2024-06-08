// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_case/todo/todo_feature.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc({required this.repository}) : super(CreateTodoInitial()) {
    on<OnCreated>((event, emit) async {
      emit(CreateTodoLoading());
      try {
        final ok = await repository.createTodo(
          CreateTodoParams(title: event.title, description: event.description),
        );
        emit(CreateTodoSuccess(ok: ok));
      } catch (e) {
        debugPrint(e.toString());
        if (e is SocketException) {
          emit(const CreateTodoFailure('No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const CreateTodoFailure('Request time out'));
        } else if (e is TypeError) {
          emit(const CreateTodoFailure('Parsing failed'));
        } else {
          emit(const CreateTodoFailure('Failed to create todo'));
        }
      }
    });
    on<OnUpdate>((event, emit) async {
      emit(UpdateTodoLoading());
      try {
        final ok = await repository.updateTodo(
          UpdateTodoParams(title: event.title, description: event.description),
          event.id,
        );
        emit(UpdateTodoSuccess(ok: ok));
      } catch (e) {
        debugPrint(e.toString());
        if (e is SocketException) {
          emit(const UpdateTodoFailure('No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const UpdateTodoFailure('Request time out'));
        } else if (e is TypeError) {
          emit(const UpdateTodoFailure('Parsing failed'));
        } else {
          emit(const UpdateTodoFailure('Failed to create todo'));
        }
      }
    });
    on<OnRemove>((event, emit) async {
      emit(RemoveTodoLoading());
      try {
        final ok = await repository.removeTodo(RemoveTodoParam(id: event.id));
        emit(RemoveTodoSuccess(ok: ok));
      } catch (e) {
        debugPrint(e.toString());
        if (e is SocketException) {
          emit(const RemoveTodoFailure('No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const RemoveTodoFailure('Request time out'));
        } else if (e is TypeError) {
          emit(const RemoveTodoFailure('Parsing failed'));
        } else {
          emit(const RemoveTodoFailure('Failed to create todo'));
        }
      }
    });
  }
}
