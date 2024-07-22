import 'package:todo_list_application/all_todo_list/model/todo_filter_type.dart';
import 'package:todo_list_application/database/local_database.dart';

import '../model/todo_list_model.dart';

class TodoLocalDatabase {
  TodoLocalDatabase._();
  static final instance = TodoLocalDatabase._();
  final _localDatabase = LocalDatabase();

  Future <List<TodoListModel>>getAll({
    TodoFilterType todoFilterType = TodoFilterType.all,
    String query = '',
  }) async{
    final response = await _localDatabase.database.query(
      'Todos',
      columns: [
        'id',
        'title',
        'description',
        'isCompleted',
        'createdAt',
        'updatedAt',
        'deletedAt',
        'completedAt',
      ],
      where: _getWhere(query, todoFilterType),
      whereArgs: _getWhereArgs(query, todoFilterType),
    );
    return response.map((map) => TodoListModel.fromMap(map)).toList();
  }

  String? _getWhere(String query, TodoFilterType todoFilterType){
    if(query.isNotEmpty) return 'title LIKE ? ';
    return todoFilterType == TodoFilterType.all ? null : 'isCompleted = ?'; 
  }

  List<Object?>? _getWhereArgs (String query, TodoFilterType todoFilterType){
    if(query.isNotEmpty) return ['%$query%'];
    return todoFilterType == TodoFilterType.all ? null : [todoFilterType == TodoFilterType.completed ? 1 : 0];
  }

  String _getAllSqlQuery(
    String query,
    TodoFilterType todoFilterType,
  ){
    if(query.isNotEmpty) return 'SELECT * FROM Todos WHERE title LIKE';
    return 'SELECT * FROM Todos WHERE isCompleted = ?';
  }

  Future<TodoListModel?> get(int id) async{
    final response = await _localDatabase.database.query(
      'Todos',
      columns: [
        'id',
        'title',
        'description',
        'isCompleted',
        'createdAt',
        'updatedAt',
        'deletedAt',
        'completedAt',
      ], 
      where: 'id = ?',
      whereArgs: [id]
    );

    return response.firstOrNull != null ? TodoListModel.fromMap(response.first) : null;
  }

  Future<TodoListModel?> add(TodoListModel todoListModel) async{
    final id = await _localDatabase.database.insert(
      'Todos', 
      todoListModel.toMap());

      final todo = todoListModel.copyWith(id: id);
      return todo;
  }

  Future<void> update(TodoListModel todoListModel) async{
    if(todoListModel.id == null) return;
    await _localDatabase.database.update(
      'Todos',
      todoListModel.toMap(),
      where: 'id = ?',
      whereArgs: [todoListModel.id]);
  }

  Future<void> delete(TodoListModel todoListModel) async{
    await _localDatabase.database.delete(
      'Todos',
      where: 'id = ?',
      whereArgs: [todoListModel.id]
    );
  }
}