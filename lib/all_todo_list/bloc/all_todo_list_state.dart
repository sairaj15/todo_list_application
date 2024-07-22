part of 'all_todo_list_bloc.dart';

class AllTodoListState {
  const AllTodoListState({
    this.todoFilterType = TodoFilterType.all, 
    this.query = '', 
    required this.isLoading, 
    required this.todoList});

    AllTodoListState copyWith({
      bool? isLoading,
      TodoFilterType? todoFilterType,
      String? query,
      List<TodoListModel>? todoList,
    }){
      return AllTodoListState(
        todoFilterType: todoFilterType ?? this.todoFilterType,
        query: query ?? this.query,
        isLoading: isLoading ?? this.isLoading,
        todoList: todoList ?? this.todoList,
      );
    }

  final List<TodoListModel> todoList;
  final bool isLoading;
  final TodoFilterType todoFilterType;
  final String query;
}
