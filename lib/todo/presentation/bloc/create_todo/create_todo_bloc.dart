// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_case/todo/todo_feature.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  final TodoRepository repository;
  CreateTodoBloc({required this.repository}) : super(CreateTodoInitial()) {
    on<OnCreated>((event, emit) async {
      emit(CreateTodoLoading());
      try {
        final ok = await repository.createTodo(
          CreateTodoParams(title: event.title, description: event.description),
        );
        emit(CreateTodoSuccess(ok: ok));
      } catch (e) {
        if (e is SocketException) {
          emit(const CreateTodoFailure('No Internet Connection'));
          debugPrint('SocketException : ${e.toString()}');
        } else if (e is TimeoutException) {
          emit(const CreateTodoFailure('Request time out'));
          debugPrint('TimeoutException : ${e.toString()}');
        } else if (e is TypeError) {
          emit(const CreateTodoFailure('Parsing failed'));
          debugPrint("TypeError : ${e.toString()}");
        } else {
          emit(const CreateTodoFailure('Failed to create todo'));
          debugPrint(e.toString());
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
        if (e is SocketException) {
          emit(const UpdateTodoFailure('No Internet Connection'));
          debugPrint('SocketException : ${e.toString()}');
        } else if (e is TimeoutException) {
          emit(const UpdateTodoFailure('Request time out'));
          debugPrint('TimeoutException : ${e.toString()}');
        } else if (e is TypeError) {
          emit(const UpdateTodoFailure('Parsing failed'));
          debugPrint("TypeError : ${e.toString()}");
        } else {
          emit(const UpdateTodoFailure('Failed to create todo'));
          debugPrint(e.toString());
        }
      }
    });
  }
}
