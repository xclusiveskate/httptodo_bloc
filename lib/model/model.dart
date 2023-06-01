import 'dart:convert';

class Todo {
  final int id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      title: map['title'] as String,
      isCompleted: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TodoResponse {
  final List<Todo> todo;

  TodoResponse({
    required this.todo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todo': todo.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoResponse.fromMap(List<dynamic> dataFromDio) {
    print(dataFromDio);
    return TodoResponse(
        todo: List<Todo>.from(dataFromDio.map((e) => Todo.fromMap(e))));
  }
}
