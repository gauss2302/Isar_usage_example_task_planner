import 'package:isar/isar.dart';
import 'package:isar_simple_todo/features/todo/data/models/todo_model.dart';

part 'isar_todo_model.g.dart';

@collection
class TaskIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  TaskModel toModel() {
    return TaskModel(id: id, text: text, isCompleted: isCompleted);
  }

  static TaskIsar fromModel(TaskModel taskModel) {
    return TaskIsar()
      ..id = taskModel.id
      ..text = taskModel.text
      ..isCompleted = taskModel.isCompleted;
  }
}
