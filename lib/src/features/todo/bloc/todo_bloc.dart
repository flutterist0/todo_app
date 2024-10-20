import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/bloc/todo_event.dart';
import 'package:todo_app/src/features/todo/bloc/todo_state.dart';
import 'package:todo_app/src/features/todo/models/todo_request_model.dart';
import 'package:todo_app/src/features/todo/service/todo_repository.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository _toDoRepository;
  ToDoBloc(this._toDoRepository) : super(ToDoInital()) {
    on<GetInComplateToDos>((event, emit) async {
      try {
        emit(ToDoLoading());
        final data = await _toDoRepository.getToDosInComplete(event.userId);
        print("IncomplateToDos: ${data}");
        emit(ToDoSuccess(data));
      } catch (e) {
        emit(ToDoFailure(e.toString()));
        print(e);
      }
    });
    on<GetComplateToDos>((event, emit) async {
      try {
        emit(ToDoLoading());
        final data = await _toDoRepository.getToDosComplete(event.userId);
        emit(ToDoSuccess(data));
      } catch (e) {
        emit(ToDoFailure(e.toString()));
        print(e);
      }
    });
    on<DeleteToDo>((event, emit) async {
      try {
        emit(ToDoLoading());
        await _toDoRepository.deleteToDo(event.userId, event.toDoId);
        final todos = await _toDoRepository.getToDosInComplete(event.userId);
        emit(ToDoSuccess(todos));
      } catch (e) {
        emit(ToDoFailure(e.toString()));
        print(e);
      }
    });

    on<UpdateToDo>((event, emit) async {
      try {
        emit(ToDoLoading());
        await _toDoRepository.taskStatusChange(
            event.userId, event.toDoId, event.isComplated);
        final todos = await _toDoRepository.getToDosInComplete(event.userId);
        emit(ToDoSuccess(todos));
      } catch (e) {
        emit(ToDoFailure(e.toString()));

        print(e);
      }
    });
    on<AddToDo>((event, emit) async {
      try {
        emit(ToDoLoading());
        await _toDoRepository.addToDo(event.toDoModel);
        print('Added');
        final todos = await _toDoRepository.getToDosInComplete(event.toDoModel.userId!);
        emit(ToDoSuccess(todos));
      } catch (e) {
        emit(ToDoFailure(e.toString()));
      }
    });
  }
}
