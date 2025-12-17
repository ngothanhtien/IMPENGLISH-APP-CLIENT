import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_app_client/model/quiz.dart';
import 'package:http/http.dart' as http;
class QuizService {
  static String? baseUrl = dotenv.env['BASE_URL_SML_3'];

  final storage = FlutterSecureStorage();
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Quiz> fetchQuiz({
    required String level,
    required String topic,
    required int numberQuestions
  }) async {
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/quiz?level=$level&topic=$topic&limit=$numberQuestions'),
        headers: headers,
      );
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        return Quiz.fromJson(dataResponse);
      }else {
        final dataResponse = json.decode(response.body);
        throw Exception('Failed to load quiz: message: ${dataResponse['message']}/${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error at fetch Quiz: $e');
    }
  }
}