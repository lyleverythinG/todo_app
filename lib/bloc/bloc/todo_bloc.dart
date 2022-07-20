import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../data/model/todo.dart';
import '../../data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository)
      : super(TodoResult(todoList: todoRepository.todoList)) {
    on<AddTodo>((event, emit) async {
      emit(TodoLoading());
      await Future.delayed(const Duration(milliseconds: 500), () {
        final updatedTodoList = todoRepository.addTodo(event.todo);
        emit(TodoResult(todoList: updatedTodoList));
      });
    });
    on<RemoveTodo>((event, emit) {
      final updatedTodoList = todoRepository.removeTodo(event.id);
      emit(TodoResult(todoList: updatedTodoList));
    });

    on<UpdateTodoState>((event, emit) {
      emit(TodoLoading());
      final updatedTodoList =
          todoRepository.updateTodoState(event.isCompleted, event.id);
      emit(TodoResult(todoList: updatedTodoList));
    });
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    try {
      final listOfTodo = (json['todo'] as List)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();

      todoRepository.todoList = listOfTodo;
      return TodoResult(todoList: listOfTodo);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    if (state is TodoResult) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
