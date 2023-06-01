import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:httptodo_bloc/model/model.dart';
import 'package:httptodo_bloc/repo/repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiRepository repo;
  TodoBloc(
    this.repo,
  ) : super(const TodoState()) {
    on<GetDataEvent>(getData);
  }

  FutureOr<void> getData(GetDataEvent event, Emitter<TodoState> emit) async {
    try {
      emit(LoadingState());
      final generatedData = await ApiRepository().getTodo();
      if (generatedData.todo.isNotEmpty) {
        emit(state.copyWith(data: generatedData.todo));
      } else {
        emit(ErrorState(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString().substring(0, 60)));
    }
  }
}
