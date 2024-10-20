import 'dart:convert';

import 'package:todo_app/src/features/todo/models/todo_model.dart';
import 'package:todo_app/src/features/todo/models/todo_request_model.dart';
import 'package:todo_app/src/features/todo/service/todo_service.dart';
import 'package:http/http.dart' as http;

class ToDoRepository extends ToDoService {
  @override
  Future<List<ToDoData>> getToDosComplete(int userId) async {
    final baseUrl =
        'https://10.0.2.2:7261/api/ToDo/getAllByIsComplated: $userId';
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print('Datas InComplete: ${response.body}');
      if (jsonBody['data'] != null) {
        final data = jsonBody['data'] as List<dynamic>;
        return data.map((e) => ToDoData.fromJson(e)).toList();
      } else {
        throw Exception('Data not found');
      }
    } else {
      throw Exception('Failed load data');
    }
  }

//getAllByIsComplated
  @override
  Future<List<ToDoData>> getToDosInComplete(int userId) async {
    final baseUrl = 'https://10.0.2.2:7261/api/ToDo/getAllByUserId: $userId';
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print('Datas InComplete: ${response.body}');
      if (jsonBody['data'] != null) {
        final data = jsonBody['data'] as List<dynamic>;
        return data.map((e) => ToDoData.fromJson(e)).toList();
      } else {
        throw Exception('Data not found');
      }
    } else {
      throw Exception('Failed load data');
    }
  }

  @override
  Future<void> deleteToDo(int userId, int toDoId) async {
    final url =
        'https://10.0.2.2:7261/api/ToDo/deleteToDo?userId=$userId&toDoId=$toDoId';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      print('task silindi');
    } else {
      print('Failed to delete item: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<void> taskStatusChange(
      int userId, int todoId, bool isComplated) async {
    final url =
        'https://10.0.2.2:7261/api/ToDo?userId=$userId&toDoId=$todoId&isComplated=$isComplated';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'toDoId': todoId,
        'isComplated': isComplated,
      }),
    );
    if (response.statusCode == 200) {
      print('Update edildi');
    } else {
      print('Xeta bashb verdi: ${response.statusCode}');
    }
  }

  @override
  Future<void> addToDo(ToDoModel toDo) async {
    const url = 'https://10.0.2.2:7261/api/ToDo/addToDo';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(toDo.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('ToDo added successfully');
    } else {
      throw Exception('Failed to add ToDo: ${response.statusCode}');
    }
  }
}
