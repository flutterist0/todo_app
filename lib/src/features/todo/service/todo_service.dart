import 'package:todo_app/src/features/todo/models/todo_model.dart';

import '../models/todo_request_model.dart';

abstract class ToDoService {
  Future<List<ToDoData>> getToDosInComplete(int userId);
  Future<List<ToDoData>> getToDosComplete(int userId);
  Future<void> deleteToDo(int userId, int toDoId);
  Future<void> taskStatusChange(int userId, int todoId, bool isComplated);
  Future<void> addToDo(ToDoModel toDo);
}
