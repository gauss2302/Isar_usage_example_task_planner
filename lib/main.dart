import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_simple_todo/features/todo/data/datasources/isar_todo_model.dart';
import 'package:isar_simple_todo/features/todo/data/repositories/todo_repo_impl.dart';
import 'package:isar_simple_todo/features/todo/domain/repositories/todo_repo.dart';
import 'package:isar_simple_todo/features/todo/presentation/pages/task_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([TaskIsarSchema], directory: dir.path);

  final isarTaskRepo = TaskRepositoryImpl(isar);

  runApp(MyApp(taskRepository: isarTaskRepo));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;
  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskPage(
        taskRepository: taskRepository,
      ),
    );
  }
}
