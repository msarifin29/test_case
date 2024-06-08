part of 'create_todo_bloc.dart';

sealed class CreateTodoState extends Equatable {
  const CreateTodoState();

  @override
  List<Object> get props => [];
}

final class CreateTodoInitial extends CreateTodoState {}

final class CreateTodoLoading extends CreateTodoState {}

final class CreateTodoSuccess extends CreateTodoState {
  final bool ok;
  const CreateTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class CreateTodoFailure extends CreateTodoState {
  final String message;
  const CreateTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class UpdateTodoLoading extends CreateTodoState {}

final class UpdateTodoSuccess extends CreateTodoState {
  final bool ok;
  const UpdateTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class UpdateTodoFailure extends CreateTodoState {
  final String message;
  const UpdateTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class RemoveTodoLoading extends CreateTodoState {}

final class RemoveTodoSuccess extends CreateTodoState {
  final bool ok;
  const RemoveTodoSuccess({required this.ok});
  @override
  List<Object> get props => [ok];
}

final class RemoveTodoFailure extends CreateTodoState {
  final String message;
  const RemoveTodoFailure(this.message);
  @override
  List<Object> get props => [message];
}
