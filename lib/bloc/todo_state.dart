part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> data;
  const TodoState({
    this.data = const <Todo>[],
  });

  @override
  List<Object> get props => [data];

  TodoState copyWith({
    List<Todo>? data,
  }) {
    return TodoState(
      data: data ?? this.data,
    );
  }
}

class LoadingState extends TodoState {}

class ErrorState extends TodoState {
  final String error;
  const ErrorState({
    required this.error,
  });
}
