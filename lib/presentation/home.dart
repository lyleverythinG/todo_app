import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/todo_bloc.dart';
import '../constants/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _todoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Add Todo"),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _todoNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                "Enter Todo",
                              ),
                            ),
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Field can't be empty"
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: Constants.kElevatedButtonStyle,
                              onPressed: () {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<TodoBloc>().add(AddTodo(
                                        todo: _todoNameController.text));
                                    _todoNameController.clear();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                'Successfully added a todo')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Failed to add a todo')));
                                }
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TodoList(),
        ),
      ),
    );
  }
}

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
