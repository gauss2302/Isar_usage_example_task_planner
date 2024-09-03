// ignore_for_file: public_member_api_docs, sort_constructors_first

class TaskModel {
  final int id;
  final String text;
  final bool isCompleted;
  TaskModel({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  TaskModel switchToComplete() {
    return TaskModel(id: id, text: text, isCompleted: !isCompleted);
  }
}
