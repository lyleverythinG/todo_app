part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final String id;

  const RemoveTodo({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateTodoState extends TodoEvent {
  final bool isCompleted;
  final String id;

  const UpdateTodoState(this.isCompleted, this.id);

  @override
  List<Object> get props => [isCompleted];
}
