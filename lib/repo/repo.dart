import 'package:dio/dio.dart';
import 'package:httptodo_bloc/model/model.dart';

class ApiRepository {
  Future<TodoResponse> getTodo() async {
    Dio dio = Dio();

    var res = await dio.get('https://jsonplaceholder.typicode.com/todos/');

    return TodoResponse.fromMap(res.data);
  }
}
