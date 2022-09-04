import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc/todo_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is TodoResult) {
          if (state.todoList.isEmpty) {
            return const Center(
              child: Text(
                "You currently have no todo's",
                style: TextStyle(fontSize: 1, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.todoList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  key: Key(state.todoList[index].todoId),
                  onDismissed: (direction) {
                    context
                        .read<TodoBloc>()
                        .add(RemoveTodo(id: state.todoList[index].todoId));
                  },
                  child: CheckboxListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      activeColor: Colors.black87,
                      tileColor: Colors.blueAccent,
                      title: Text(
                        state.todoList[index].todoTitle,
                        style: state.todoList[index].isCompleted
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                      value: state.todoList[index].isCompleted,
                      onChanged: (value) async {
                        context.read<TodoBloc>().add(
                              UpdateTodoState(
                                  value!, state.todoList[index].todoId),
                            );
                      }),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
