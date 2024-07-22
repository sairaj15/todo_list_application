import 'package:flutter/material.dart';
import 'package:todo_list_application/home/view/home_screen.dart';

import 'global_provider.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      child: MaterialApp(
        scaffoldMessengerKey:  scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ));
  }
}