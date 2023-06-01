import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:httptodo_bloc/bloc/todo_bloc.dart';
import 'package:httptodo_bloc/model/model.dart';

class TodoUi extends StatefulWidget {
  const TodoUi({super.key});

  @override
  State<TodoUi> createState() => _TodoUiState();
}

class _TodoUiState extends State<TodoUi> {
  bool isSearching = false;
  TextEditingController searchControl = TextEditingController();
  List<Todo> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchControl,
                onChanged: (value) {
                  setState(() {});
                },
                decoration:
                    const InputDecoration(labelText: "Search todo here"),
              )
            : const Text("Getting Todo from Json Place Holder"),
        actions: [
          IconButton(
              onPressed: () {
                isSearching = !isSearching;
                if (isSearching) {
                  searchControl.clear();
                }
                setState(() {});
              },
              icon: isSearching
                  ? const Icon(Icons.cancel)
                  : const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                // todos = state.data;
                if (isSearching && searchControl.text.isNotEmpty) {
                  final query = searchControl.text.toLowerCase();
                  todos = state.data
                      .where((element) => element.title.contains(query))
                      .toList();
                } else {
                  todos = state.data;
                }

                return Center(
                  child: Column(
                    children: [
                      state is LoadingState
                          ? const CircularProgressIndicator.adaptive()
                          : OutlinedButton(
                              onPressed: () {
                                getTodo();
                              },
                              child: const Text("Get Todo")),
                      Container(
                          child: todos.isNotEmpty
                              ? ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: todos.length,
                                  itemBuilder: (context, index) {
                                    final todo = todos[index];
                                    return ListTile(
                                        tileColor: todo.id % 2 == 0
                                            ? Colors.white10
                                            : Colors.pinkAccent,
                                        onTap: () {},
                                        leading: Text(todo.id.toString()),
                                        title: Text(todo.title),
                                        trailing: SizedBox(
                                          width: 98,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.delete))
                                            ],
                                          ),
                                        ));
                                  })
                              : const SizedBox.shrink())
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  getTodo() {
    context.read<TodoBloc>().add(GetDataEvent());
  }
}
