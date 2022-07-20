import 'package:uuid/uuid.dart';

import '../model/todo.dart';

class TodoRepository {
  final uuid = const Uuid();
  List<Todo> todoList = [];

  List<Todo> addTodo(String todoTitle) {
    final todo = Todo(todoTitle, uuid.v4(), false);
    todoList.add(todo);
    return todoList;
  }

  List<Todo> removeTodo(String id) {
    todoList.removeWhere((element) => element.todoId == id);
    return todoList;
  }

  List<Todo> updateTodoState(bool isCompleted, String id) {
    for (Todo element in todoList) {
      if (element.todoId == id) {
        element.isCompleted = isCompleted;
      }
    }
    return todoList;
  }
}
