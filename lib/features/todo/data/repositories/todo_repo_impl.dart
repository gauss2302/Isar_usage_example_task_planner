import 'package:isar/isar.dart';
import 'package:isar_simple_todo/features/todo/data/datasources/isar_todo_model.dart';
import 'package:isar_simple_todo/features/todo/data/models/todo_model.dart';
import 'package:isar_simple_todo/features/todo/domain/repositories/todo_repo.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Isar database;

  TaskRepositoryImpl(this.database);

  @override
  Future<void> addTask(TaskModel newTask) async {
    final tasks = TaskIsar.fromModel(newTask);
    return database.writeTxn(() => database.taskIsars.put(tasks));
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    await database.writeTxn(() => database.taskIsars.delete(task.id));
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final tasks = await database.taskIsars.where().findAll();
    return tasks.map((taskIsars) => taskIsars.toModel()).toList();
  }

  @override
  Future<void> updateTask(TaskModel task) {
    final tasks = TaskIsar.fromModel(task);
    return database.writeTxn(() => database.taskIsars.put(tasks));
  }
}
