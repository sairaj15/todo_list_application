part of 'all_todo_list_bloc.dart';

abstract class AllTodoListEvent {
  const AllTodoListEvent();
}

class AllTodoListEventFetchEvent extends AllTodoListEvent {
  const AllTodoListEventFetchEvent({
    this.todoFilterType = TodoFilterType.all, 
    this.query = ''
    });

  final TodoFilterType todoFilterType;
  final String query;
}

class AllTodoListEventCompletedNotCompletedEvent extends AllTodoListEvent{
  final TodoListModel todoListModel;

  AllTodoListEventCompletedNotCompletedEvent({required this.todoListModel});
}