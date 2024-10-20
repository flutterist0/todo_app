import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/auth/bloc/auth_event.dart';
import 'package:todo_app/src/features/todo/models/todo_model.dart';
import 'package:todo_app/src/features/todo/models/todo_request_model.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
  @override
  List<Object?> get props => [];
}

class AddToDo extends ToDoEvent {
  final ToDoModel toDoModel;
  const AddToDo(this.toDoModel);
  @override
  // TODO: implement props
  List<Object?> get props => [toDoModel];
}

class GetInComplateToDos extends ToDoEvent {
  final int userId;
  const GetInComplateToDos(this.userId);
}


class GetComplateToDos extends ToDoEvent {
  final int userId;
  const GetComplateToDos(this.userId);
}
class DeleteToDo extends ToDoEvent {
  final int userId;
  final int toDoId;
  const DeleteToDo(this.userId, this.toDoId);
}

class UpdateToDo extends ToDoEvent{
  final int userId;
  final int toDoId;
  final bool isComplated;
  const UpdateToDo(this.userId, this.toDoId, this.isComplated);
}