import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_application/all_todo_list/bloc/all_todo_list_bloc.dart';
import 'package:todo_list_application/create_todo.dart/view/create_todo_list_screen.dart';

class AllTodoListScreen extends StatefulWidget {
  const AllTodoListScreen({super.key});

  @override
  State<AllTodoListScreen> createState() => _AllTodoListScreenState();
}

class _AllTodoListScreenState extends State<AllTodoListScreen> {
  @override
  void initState() {
    context.read<AllTodoListBloc>().add(const AllTodoListEventFetchEvent());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTodoListBloc, AllTodoListState>(builder: (context, state){
      return ListView.separated(
        itemCount: state.todoList.length,
        itemBuilder: (context, index) {
          final todoList = state.todoList[index];
          return ListTile(
            leading: Checkbox(
              value: todoList.isCompleted, 
              onChanged: (value){
              context.read<AllTodoListBloc>().add(AllTodoListEventCompletedNotCompletedEvent(todoListModel: todoList));
            }),
            title: Text(
              todoList.title,
              maxLines: 3,
            ),
            subtitle: todoList.description != null ? Text(
              todoList.description!,
              maxLines: 3,
            ) : null,
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateTodoListScreen()
                )
              );
            },
          );
        }, separatorBuilder: (_, __) => const Divider(),
      );
    });
  }
}