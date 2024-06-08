import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_case/core/helper/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_case/injection.dart';
import 'package:test_case/todo/todo_feature.dart';
import 'package:test_case/injection.dart' as di;

void main() async {
  await di.init();
  di.sl.allowReassignment = true;
  await dotenv.load(fileName: ".env");
  await initSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(repository: sl()),
        ),
        BlocProvider(
          create: (context) => FetchTodosBloc(repository: sl()),
        ),
      ],
      child: MaterialApp(
        title: 'Test Case',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue[100]),
        ),
        home: const TodoPage(),
      ),
    );
  }
}
