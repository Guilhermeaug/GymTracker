import 'dart:async';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/exercise.dart';
import '../models/record.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio();
    _dio.options.baseUrl = 'http://192.168.0.121:8080/api/';
    _dio.options.connectTimeout = 8000;
    _dio.options.receiveTimeout = 8000;
  }

  Future<Result<List<Record>, DioError>> getRecords() async {
    try {
      final response = await _dio.get('records');
      final records = response.data as List;
      return Success(records.map((e) => Record.fromJson(e)).toList());
    } on DioError catch (e) {
      return Error(e);
    }
  }

  Future<Response> createRecord({dynamic data}) async {
    return await _dio.post('records', data: data);
  }

  Future<Result<void, DioError>> deleteRecordById(int id) async {
    try {
      await _dio.delete('records/$id');
      return const Success(null);
    } on DioError catch (e) {
      return Error(e);
    }
  }

  Future<Result<Record, DioError>> updateRecordById(
    int id, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put('records/$id', data: data);
      return Success(Record.fromJson(response.data));
    } on DioError catch (e) {
      return Error(e);
    }
  }

  Future<Result<List<Exercise>, DioError>> getExercisesByRecordId(
      int recordId) async {
    try {
      final response = await _dio.get('exercises/record/$recordId');
      final exercises = response.data as List;
      return Success(exercises.map((e) => Exercise.fromJson(e)).toList());
    } on DioError catch (e) {
      return Error(e);
    }
  }

  Future<Response> createExercise({dynamic data}) async {
    return await _dio.post('exercises', data: data);
  }

  Future<Result<void, DioError>> deleteExerciseById(int id) async {
    try {
      await _dio.delete('exercises/$id');
      return const Success(null);
    } on DioError catch (e) {
      return Error(e);
    }
  }

  Future<Result<Exercise, DioError>> updateExerciseById(
    int id, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put('exercises/$id', data: data);
      return Success(Exercise.fromJson(response.data));
    } on DioError catch (e) {
      return Error(e);
    }
  }
}
