import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/bloc/todo_bloc.dart';
import 'data/repository/todo_repository.dart';
import 'presentation/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(RepositoryProvider(
      create: (context) => TodoRepository(),
      child: const TodoApp(),
    )),
    storage: storage,
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        RepositoryProvider.of<TodoRepository>(context),
      ),
      child: MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData()
              .copyWith(backgroundColor: const Color.fromRGBO(18, 26, 28, 1)),
          appBarTheme: const AppBarTheme()
              .copyWith(backgroundColor: const Color.fromRGBO(18, 26, 28, 1)),
        ),
        debugShowCheckedModeBanner: false,
        home: const Home(),
      ),
    );
  }
}
