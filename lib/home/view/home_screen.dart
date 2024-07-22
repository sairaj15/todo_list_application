import 'package:flutter/material.dart';
import 'package:todo_list_application/all_todo_list/view/all_todo_list_screen.dart';
import 'package:todo_list_application/create_todo.dart/view/create_todo_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateTodoListPage()));
              },
              label: const Icon(Icons.add))
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Statistics',
          )
        ],
      ),
      body: buildBody(),
    );
  }
  
  buildBody() {
    if(selectedIndex == 0) return const AllTodoListScreen();
  }
}
