import 'package:dio/dio.dart';

class Api {
  Dio _dio = new Dio();

  Future<dynamic> get({String endpoint}) async {
    try{
      Response response = await _dio.get(endpoint);
      return response.data;
    } catch(error) {
      print(error);
    }
  }

  Future<dynamic> post({String endpoint}) async {
    try{
      Response response = await _dio.post(endpoint);
      return response.data;
    } catch(error) {
      print(error);
    }
  }

  Future<dynamic> put({String endpoint}) async {
    try{
      Response response = await _dio.put(endpoint);
      return response.data;
    } catch(error) {
      print(error);
    }
  }

  Future<dynamic> delete({String endpoint}) async {
    try{
      Response response = await _dio.delete(endpoint);
      return response.data;
    } catch(error) {
      print(error);
    }
  }
}