part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];

  Map<String, dynamic>? toJson() {
    return null;
  }
}

class TodoLoading extends TodoState {}

class TodoResult extends TodoState {
  final List<Todo> todoList;

  const TodoResult({required this.todoList});

  @override
  List<Object> get props => [todoList];

  @override
  Map<String, dynamic> toJson() {
    return {'todo': todoList};
  }
}
