import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app_client/model/quiz_result/quiz_result.dart';
class quizResultService{
  static String? baseUrl =  dotenv.env['BASE_URL_SML_3'];
  final _storage = FlutterSecureStorage();

  static const Map<String, String> _defaultHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Map<String,dynamic>> createQuizResult ({
    required QuizResult? quiz,
    required String? userId
  }) async {
    try{
      final body = {
        "level": quiz?.level,
        "category": quiz?.category,
        "totalQuestions": quiz?.totalQuestions,
        "correctAnswers": quiz?.correctAnswers,
        "incorrectAnswers": quiz?.incorrectAnswers,
        "questions": quiz?.questions?.map((e){
            final map = e.toJson();
            map.remove("_id");
            return map;
          }
        ).toList(),
        "statusFinish": quiz?.statusFinish,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/quiz-results/create/$userId"),
        headers: _defaultHeaders,
        body: json.encode(body)
      );
      if(response.statusCode == 200){
        final Map<String,dynamic> result = json.decode(response.body);
        return result;
      }else {
        final Map<String,dynamic> result = json.decode(response.body);
        throw("Error in function create quiz result at service: ${result['message']}");
      }
    }catch(e){
      throw("Error in function create quiz result at service: $e");
    }
  }

  Future<List<QuizResult>> getQuizResultByUserId({required String? userId}) async
  {
    try{
      final response = await http.post(
          Uri.parse("$baseUrl/quiz-results/user/$userId"),
          headers: _defaultHeaders,
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final List<QuizResult> result = data['data'];
        return result;
      }else{
        throw("Error in function get quiz result by id at service: ${response.statusCode}");
      }
    }catch(e){
      throw("Error in function get quiz result by id at service: $e");
    }
  }

  Future<QuizResult> getDetailQuizResultById({required String? quizResultId}) async {
    try{
      final response = await http.get(
        Uri.parse("$baseUrl/quiz-results/detail/$quizResultId"),
        headers: _defaultHeaders,
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final result = QuizResult.fromJson(data['data']);;
        return result;
      }else{
        throw("Error in function get quiz result by id at service: ${response.statusCode}");
      }
    }catch(e){
      throw("Error in function get quiz result by id at service: $e");
    }
  }
}