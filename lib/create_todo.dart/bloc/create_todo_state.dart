part of 'create_todo_bloc.dart';

class CreateTodoState {
  final CreateTodoStatus todoListStatus;

  const CreateTodoState({required this.todoListStatus});
}

enum CreateTodoStatus {
  initial,
  loading,
  success,
}

class CreateTodoStateAdd extends CreateTodoState{
  CreateTodoStateAdd({required super.todoListStatus});
}

class CreateTodoStateUpdate extends CreateTodoState{
  CreateTodoStateUpdate({required super.todoListStatus});
}
