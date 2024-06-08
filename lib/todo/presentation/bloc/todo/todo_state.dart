part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class CreateTodoInitial extends TodoState {}

final class CreateTodoLoading extends TodoState {}

final class CreateTodoSuccess extends TodoState {
  final bool ok;
  const CreateTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class CreateTodoFailure extends TodoState {
  final String message;
  const CreateTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class UpdateTodoLoading extends TodoState {}

final class UpdateTodoSuccess extends TodoState {
  final bool ok;
  const UpdateTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class UpdateTodoFailure extends TodoState {
  final String message;
  const UpdateTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class RemoveTodoLoading extends TodoState {}

final class RemoveTodoSuccess extends TodoState {
  final bool ok;
  const RemoveTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class RemoveTodoFailure extends TodoState {
  final String message;
  const RemoveTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}
