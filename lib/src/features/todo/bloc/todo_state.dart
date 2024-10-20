import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/todo/models/todo_request_model.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object?> get props => [];
}

class ToDoInital extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoSuccess extends ToDoState {
  final List<ToDoData> toDo;
  const ToDoSuccess(this.toDo);
}

class ToDoFailure extends ToDoState {
  final String error;
  const ToDoFailure(this.error);
}

class ToDoDeleted extends ToDoState {
  final int userId;
  final int toDoId;
  const ToDoDeleted(this.userId,this.toDoId);
}