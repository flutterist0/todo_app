import '../models/todo_model.dart';

abstract class ToDoService{
  Future<List<ToDoData>> getToDosInComplete(int userId);
  Future<List<ToDoData>> getToDosComplete(int userId);
}