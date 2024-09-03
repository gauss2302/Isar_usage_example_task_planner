import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_simple_todo/features/todo/data/models/todo_model.dart';
import 'package:isar_simple_todo/features/todo/presentation/cubit/task_cubit.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  void _showAddTaskBox(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    final textController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.add_task, color: Color(0xFF6C63FF)),
                  SizedBox(width: 10),
                  Text('Add New Task',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF2D3748),
                      )),
                ],
              ),
              content: Container(
                width: double.maxFinite,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Enter task description',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.description, color: Color(0xFF6C63FF)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 20, color: Colors.grey[600]),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Task will be added to your current list',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      taskCubit.addTask(textController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Add Task", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              elevation: 5,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FD),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskBox(context),
        icon: Icon(Icons.add),
        label: Text('Add Task', style: GoogleFonts.poppins()),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: BlocBuilder<TaskCubit, List<TaskModel>>(
        builder: (context, tasks) {
          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: Text(
                      task.text,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        color: task.isCompleted ? Colors.grey : Color(0xFF2D3748),
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => taskCubit.markAsCompleted(task),
                      activeColor: Color(0xFF6C63FF),
                    ),
                    trailing: IconButton(
                      onPressed: () => taskCubit.deleteTask(task),
                      icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
