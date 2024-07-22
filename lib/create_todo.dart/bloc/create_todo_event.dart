part of 'create_todo_bloc.dart';


abstract class CreateTodoEvent {
  const CreateTodoEvent();
}

class CreateTodoEventSaveEvent extends CreateTodoEvent{
  const CreateTodoEventSaveEvent({
    required this.title, 
    required this.description});

  final String title;
  final String description;
}

class CreateTodoEventUpdateEvent extends CreateTodoEvent{
  const CreateTodoEventUpdateEvent({required this.todoListModel});

  final TodoListModel todoListModel;
}
