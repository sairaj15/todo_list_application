import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_application/all_todo_list/bloc/all_todo_list_bloc.dart';
import 'package:todo_list_application/create_todo.dart/bloc/create_todo_bloc.dart';
import 'package:todo_list_application/model/todo_list_model.dart';

class CreateTodoListScreen extends StatefulWidget {
  const CreateTodoListScreen({super.key, this.todoListModel});

  final TodoListModel? todoListModel;

  @override
  State<CreateTodoListScreen> createState() => _CreateTodoListScreenState();
}

class _CreateTodoListScreenState extends State<CreateTodoListScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todoListModel?.title ?? '';
    descriptionController.text = widget.todoListModel?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTodoBloc, CreateTodoState>(
      builder: (context, state) {
        if (state.todoListStatus == CreateTodoStatus.success) {
          context
              .read<AllTodoListBloc>()
              .add(const AllTodoListEventFetchEvent());
          Navigator.pop(context);
        }
        if (state is CreateTodoStateAdd) {
          const SnackBar(content: Text('Todo Created!'));
        } else {
          const SnackBar(content: Text("Todolist Updated"));
        }
        return PopScope(
            canPop:
                state.todoListStatus == CreateTodoStatus.loading ? false : true,
            child: Stack(children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.todoListModel == null
                        ? 'Create Todo List'
                        : 'Edit Todo List',
                  ),
                  centerTitle: true,
                ),
                floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final title = titleController.text;
                        final description = descriptionController.text;
                        if (widget.todoListModel != null) {
                          context
                              .read<CreateTodoBloc>()
                              .add(CreateTodoEventUpdateEvent(
                                  todoListModel: widget.todoListModel!.copyWith(
                                title: title,
                                description: description,
                              )));
                        } else {
                          context
                              .read<CreateTodoBloc>()
                              .add(CreateTodoEventSaveEvent(
                                title: title,
                                description: description,
                              ));
                        }
                      }
                    },
                    label: const Text("Save")),
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLength: 100,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                            controller: descriptionController,
                            maxLength: 500,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ]));
      },
      listener: (context, state) {
        if (state.todoListStatus == CreateTodoStatus.success) {
          context
              .read<AllTodoListBloc>()
              .add(const AllTodoListEventFetchEvent());
          Navigator.of(context).pop();
          log("Todo created");
        }

        if (state.todoListStatus == CreateTodoStatus.loading) {
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 20),
              Material(
                  color: Colors.transparent, child: Text("Creating Todo......"))
            ],
          );
        }
      },
    );
  }
}
