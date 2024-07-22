class TodoListModel {
   const TodoListModel({
    this.id, 
    required this.title, 
    this.description,  
    required this.isCompleted, 
    this.updatedAt, 
    this.completedAt, 
    this.deletedAt, 
    required this.createdAt});

    factory TodoListModel.fromMap(Map<String, dynamic> map){
      return TodoListModel(
        id: map['id'] as int,
        title: map['title'] as String,
        description: map['description'] as String?,
        isCompleted: map['isCompleted'] as int == 1,
        updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
        completedAt: map['completedAt']!= null ? DateTime.fromMillisecondsSinceEpoch(map['completedAt'] as int) : null,
        deletedAt: map['deletedAt']!= null ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int) : null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      );
    }

    TodoListModel copyWith({
      int? id,
      String? title,
      String?  description,
      DateTime? updatedAt,
      bool? isCompleted,
      DateTime? completedAt,
    }){
      return TodoListModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description, 
        isCompleted: isCompleted ?? this.isCompleted,
        updatedAt: updatedAt ?? this.updatedAt,
        completedAt: completedAt ?? this.completedAt,
        deletedAt: deletedAt,
        createdAt: createdAt,
      );
    }

    Map<String, dynamic> toMap(){
      return {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted == true ? 1 : 0,
        'updatedAt': updatedAt?.millisecondsSinceEpoch,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'deletedAt': deletedAt?.millisecondsSinceEpoch,
        'completedAt': completedAt?.millisecondsSinceEpoch,
      };
    }
    
  final int? id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final DateTime? deletedAt;
  final DateTime createdAt;
}