// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class OnCreated extends TodoEvent {
  const OnCreated(this.title, this.description);
  final String title;
  final String description;
  @override
  List<Object> get props => [title, description];
  @override
  String toString() {
    return 'OnCreated{title: $title, description: $description}';
  }
}

class OnUpdate extends TodoEvent {
  const OnUpdate({
    this.title,
    this.description,
    required this.id,
  });
  final String? title;
  final String? description;
  final int id;
  @override
  List<Object> get props => [title!, description!, id];
  @override
  String toString() {
    return 'OnUpdate{title: $title, description: $description, id: $id}';
  }
}

class OnRemove extends TodoEvent {
  const OnRemove({required this.id});
  final int id;
  @override
  List<Object> get props => [id];
  @override
  String toString() {
    return 'OnRemove{id: $id}';
  }
}
