// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:isar_simple_todo/features/todo/domain/repositories/todo_repo.dart';
import 'package:isar_simple_todo/features/todo/presentation/cubit/task_cubit.dart';
import 'package:isar_simple_todo/features/todo/presentation/pages/task_view.dart';

class TaskPage extends StatelessWidget {
  final TaskRepository taskRepository;
  const TaskPage({
    Key? key,
    required this.taskRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(taskRepository),
      child: Theme(
        data: ThemeData(
          primaryColor: Color(0xFF6C63FF),
          scaffoldBackgroundColor: Color(0xFFF8F9FD),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
              color: Color(0xFF2D3748),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Your Tasks'),
            actions: [
              IconButton(
                icon: Icon(Icons.light_mode, color: Color(0xFF6C63FF)),
                onPressed: () {
                  // Implement theme switching logic here
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TaskView(),
            ),
          ),
        ),
      ),
    );
  }
}
