import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_app_client/model/post/post_detail_response.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app_client/service/request_auth.dart';

class PostDetailService {
  static String? baseUrl =  dotenv.env['BASE_URL_SML_3'];

  Future<Comment> addComment({
    required String postId,
    required String content,
  }) async {
    try{
      final response = await requestWithAuth((token) async {
        return await http.post(
            Uri.parse("$baseUrl/comments/create/$postId"),
            headers: {
              "Content-type" : "Application/json",
              "Authorization": "Bearer $token"
            },
            body: json.encode({
              "content": content,
            })
        );
      });

      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        final result = Comment.fromJson(dataResponse['data']);
        return result;
      }else{
        throw Exception("Error add comment at postServiceDetail: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error add comment at postServiceDetail: $e");
    }
  }

  Future<Map<String,dynamic>> toggleLiked({
    required String postId
  }) async {
    try{
      final response = await requestWithAuth((token) async {
        return await http.post(
          Uri.parse("$baseUrl/likes/toggle-like/$postId"),
          headers: {
            "Content-type" : "Application/json",
            "Authorization": "Bearer $token"
          },
        );
      });
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        return dataResponse;
      }else{
        throw Exception("Error at toggle like: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at toggle like: $e");
    }
  }

  Future<Map<String,dynamic>> checkLiked({
    required String postId
  }) async {
    try{
      final response = await requestWithAuth((token) async {
        return await http.get(
          Uri.parse("$baseUrl/likes/check-like/$postId"),
          headers: {
            "Content-type" : "Application/json",
            "Authorization": "Bearer $token"
          },
        );
      });
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        return dataResponse;
      }else{
        throw Exception("Error at toggle like at postServiceDetail: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at toggle like at postServiceDetail: $e");
    }
  }

  Future<Map<String,dynamic>> deleteComment({
    required String commentId,
  }) async {
    try{
      final response = await requestWithAuth((token) async {
        return await http.delete(
          Uri.parse("$baseUrl/comments/delete/$commentId"),
          headers: {
            "Content-type": "Application/json",
            "Authorization": "Bearer $token"
          },
        );
      });
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        return dataResponse;
      }else{
        throw Exception("Error at delete commemt at postServiceDetail: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at delete commemt at postServiceDetail: $e");
    }
  }

  Future<Map<String,dynamic>> updateComment({
    required String commentId,
    required String content
  }) async {
    try{
      final response = await requestWithAuth((token) async {
        return await http.put(
          Uri.parse("$baseUrl/comments/update/$commentId"),
          headers: {
            "Content-type": "Application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode({
            "content": content
          })
        );
      });
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        final Map<String,dynamic> result = dataResponse;
        return result;
      }else{
        throw Exception("Error at update commemt at postServiceDetail: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at update commemt at postServiceDetail: $e");
    }
  }
}