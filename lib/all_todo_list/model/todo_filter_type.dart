enum TodoFilterType {
  all(name: 'All'),
  completed(name: 'Completed'),
  notCompleted(name: 'Not Completed'),
  ;

  const TodoFilterType({required this.name});

  final String name;
}
