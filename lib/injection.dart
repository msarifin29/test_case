import 'package:get_it/get_it.dart';
import 'package:test_case/todo/todo_feature.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<TodoRemoteDatasource>(
    () => TodoRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(datasource: sl()),
  );
  sl.registerFactory(() => TodoBloc(repository: sl()));
  sl.registerFactory(() => FetchTodosBloc(repository: sl()));
}
