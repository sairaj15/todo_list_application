import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_application/all_todo_list/bloc/all_todo_list_bloc.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AllTodoListBloc()),
    ], child: child);
  }
}
