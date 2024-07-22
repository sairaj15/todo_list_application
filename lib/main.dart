import 'package:flutter/material.dart';
import 'package:todo_list_application/application.dart';

import 'database/local_database.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase().initialize();
  runApp(const Application());
}