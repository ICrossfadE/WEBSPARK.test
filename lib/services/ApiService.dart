import 'dart:convert';
import 'dart:io';

import 'package:webspark_test/models/result_model.dart';
import 'package:webspark_test/utils/AlgoritmMixin.dart';

import 'package:webspark_test/models/coordinates_model.dart';

class ApiService with AlgorithmMixin {
  late String _url;
  late List<InputModel> resultData;
  late List<Result> solutions = [];

  // Зберігаємо url
  void setUrl(String url) {
    if (isValidUrl(url)) {
      _url = url;
    } else {
      throw Exception('Некоректний URL: $url');
    }
  }

  // Валідуємо
  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  //Запуск алгоритму
  Future<void> startAlgorithm() async {
    await getData();
    if (resultData.isEmpty) {
      print('resultData є порожнім або нульовим');
    }

    solutions.clear();

    for (var task in resultData) {
      try {
        var result = await findShortestPath(task);
        solutions.add(result);
        print('Processed task ${task.id}: ${result.path}');
      } catch (e) {
        print('Помилка під час обробки task із id ${task.id}: $e');
      }
    }
    print('Processed ${solutions.length} out of ${resultData.length} tasks');
  }

  //Отримуєм завдання
  Future getData() async {
    final client = HttpClient();

    try {
      final uri = Uri.parse(_url);
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody)['data'] as List<dynamic>;

        resultData = data.map((item) => InputModel.fromJson(item)).toList();

        print('loaded: $resultData');
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
  }

  Future<void> postData() async {
    if (solutions.isEmpty) {
      throw Exception('Not have solutions');
    }

    final client = HttpClient();

    try {
      final uri = Uri.parse(_url);
      final request = await client.postUrl(uri);

      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      // Конвертуємо всі результати в JSON
      final data = solutions.map((solution) => solution.toJson()).toList();
      print('Sending data: ${jsonEncode(data)}');

      request.write(jsonEncode(data));

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        print('Data sent successfully');
        print('Response: $responseBody');
      } else {
        print('Error response: $responseBody');
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      client.close();
    }
  }
}
