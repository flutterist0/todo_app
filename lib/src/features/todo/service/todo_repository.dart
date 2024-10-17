import 'package:todo_app/src/features/todo/models/todo_model.dart';
import 'package:todo_app/src/features/todo/service/todo_service.dart';
import 'package:http/http.dart' as http;
class ToDoRepository extends ToDoService{
  @override
  Future<List<ToDoData>> getToDosComplete(int userId) async{
    final baseUrl =
        'https://localhost:7261/api/ToDo/getAllByUserId: $userId';
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonBody = response.body as List;
      return jsonBody.map((e) => ToDoData.fromJson(e)).toList();
    } else {
      throw Exception('Failed load data');
    }
  }

  @override
  Future<List<ToDoData>> getToDosInComplete(int userId) async{
   final baseUrl = 'https://localhost:7261/api/ToDo/getAllByIsComplated: $userId';
   final response = await http.get(Uri.parse(baseUrl));
   if (response.statusCode == 200) {
     final jsonBody = response.body as List;
     return jsonBody.map((e) => ToDoData.fromJson(e)).toList();
   } else {
     throw Exception('Failed load data');
   }
  }

}