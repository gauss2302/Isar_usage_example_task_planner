import 'package:isar_simple_todo/features/todo/data/models/todo_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks();

  Future<void> addTask(TaskModel newTask);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(TaskModel task);
}
