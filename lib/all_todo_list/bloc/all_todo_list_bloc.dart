import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_list_application/all_todo_list/model/todo_filter_type.dart';
import 'package:todo_list_application/database/todo_local_database.dart';
import 'package:todo_list_application/model/todo_list_model.dart';

part 'all_todo_list_event.dart';
part 'all_todo_list_state.dart';

class AllTodoListBloc extends Bloc<AllTodoListEvent, AllTodoListState> {
  AllTodoListBloc() : super(const AllTodoListState(isLoading: false, todoList: [])) {
    on<AllTodoListEventFetchEvent>(_onAllTodoListEventFetchEvent);
    on<AllTodoListEventCompletedNotCompletedEvent>(_onAllTodoListEventCompletedNotCompletedEvent);
  }

  FutureOr<void> _onAllTodoListEventFetchEvent(AllTodoListEventFetchEvent event, Emitter<AllTodoListState> emit) async{
    emit(state.copyWith(isLoading: true));

    final todoList = await TodoLocalDatabase.instance.getAll(
      todoFilterType: event.todoFilterType,
    );

    emit(
      AllTodoListState(isLoading: false, todoList: todoList)
    );
  }

  FutureOr<void> _onAllTodoListEventCompletedNotCompletedEvent(AllTodoListEventCompletedNotCompletedEvent event, Emitter<AllTodoListState> emit) async{
    final todoListModel = event.todoListModel.copyWith(
      isCompleted: !event.todoListModel.isCompleted,
      completedAt: DateTime.now()
    );

    await TodoLocalDatabase.instance.update(todoListModel);
    add(
      AllTodoListEventFetchEvent(
        todoFilterType: state.todoFilterType,
        query: state.query,
      )
    );
  }
}
