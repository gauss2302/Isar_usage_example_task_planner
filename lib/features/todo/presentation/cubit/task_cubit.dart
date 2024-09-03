// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:isar_simple_todo/features/todo/data/models/todo_model.dart';
import 'package:isar_simple_todo/features/todo/domain/repositories/todo_repo.dart';

class TaskCubit extends Cubit<List<TaskModel>> {
  final TaskRepository taskRepository;

  TaskCubit(this.taskRepository) : super([]) {
    loadTask();
  }

  Future<void> loadTask() async {
    final taskList = await taskRepository.getTasks();
    emit(taskList);
  }

  Future<void> addTask(String text) async {
    final newTask = TaskModel(id: DateTime.now().millisecondsSinceEpoch, text: text);

    await taskRepository.addTask(newTask);

    loadTask();
  }

  Future<void> deleteTask(TaskModel task) async {
    await taskRepository.deleteTask(task);

    loadTask();
  }

  Future<void> markAsCompleted(TaskModel finishedTask) async {
    final isCompleted = finishedTask.switchToComplete();

    await taskRepository.updateTask(isCompleted);

    loadTask();
  }
}
