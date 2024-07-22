import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_application/create_todo.dart/bloc/create_todo_bloc.dart';
import 'package:todo_list_application/create_todo.dart/view/create_todo_list_screen.dart';
import 'package:todo_list_application/model/todo_list_model.dart';

class CreateTodoListPage extends StatelessWidget {
  const CreateTodoListPage({super.key, this.todoListModel});
  final TodoListModel? todoListModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CreateTodoBloc(),
    child: CreateTodoListScreen(
      todoListModel: todoListModel,
    ),);
  }
}