part of 'fetch_todos_bloc.dart';

sealed class FetchTodosState extends Equatable {
  const FetchTodosState();

  @override
  List<Object> get props => [];
}

final class FetchTodosInitial extends FetchTodosState {}

final class FetchTodosLoading extends FetchTodosState {}

final class FetchTodosSucccess extends FetchTodosState {
  final TodosResponses todos;
  final String input;
  const FetchTodosSucccess({required this.todos, this.input = ''});
  @override
  List<Object> get props => [todos];
}

final class FetchTodosFailure extends FetchTodosState {
  final String message;
  const FetchTodosFailure(this.message);
  @override
  List<Object> get props => [message];
}
