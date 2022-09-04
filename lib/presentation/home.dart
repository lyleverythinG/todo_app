import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_hydrated_bloc/presentation/widgets/todo_list.dart';
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
