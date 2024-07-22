import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_list_application/model/todo_list_model.dart';

import '../../database/todo_local_database.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc() : super(const CreateTodoState(todoListStatus: CreateTodoStatus.initial)) {
    on<CreateTodoEventSaveEvent>(_onCreateTodoEventSaveEvent);
    on<CreateTodoEventUpdateEvent>(_onCreateTodoEventUpdateEvent);
  }

  FutureOr<void> _onCreateTodoEventSaveEvent(CreateTodoEventSaveEvent event, Emitter<CreateTodoState> emit) async{
    emit(
      const CreateTodoState(todoListStatus: CreateTodoStatus.loading)
    );

    final todoListModel = TodoListModel(
      title: event.title, 
      createdAt: DateTime.now(),
      description: event.description,
      isCompleted: false,
      );

      await TodoLocalDatabase.instance.add(todoListModel);
      emit(
        const CreateTodoState(todoListStatus: CreateTodoStatus.success)
      );
  }

  FutureOr<void> _onCreateTodoEventUpdateEvent(CreateTodoEventUpdateEvent event, Emitter<CreateTodoState> emit) async{
    emit(
      const CreateTodoState(todoListStatus: CreateTodoStatus.loading)
    );

    await TodoLocalDatabase.instance.update(
      event.todoListModel.copyWith(updatedAt: DateTime.now())
    );

    emit(
      const CreateTodoState(todoListStatus: CreateTodoStatus.success)
    );
  }
}
