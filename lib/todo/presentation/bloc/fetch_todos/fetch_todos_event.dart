// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fetch_todos_bloc.dart';

sealed class FetchTodosEvent extends Equatable {
  const FetchTodosEvent();

  @override
  List<Object> get props => [];
}

class AllTodo extends FetchTodosEvent {
  final String name;
  final bool isFilter;
  const AllTodo({
    this.name = '',
    this.isFilter = false,
  });
  @override
  List<Object> get props => [name, isFilter];
}
