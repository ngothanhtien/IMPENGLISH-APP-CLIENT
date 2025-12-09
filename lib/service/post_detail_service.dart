import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_app_client/model/post/post_detail_response.dart';
import 'package:http/http.dart' as http;

class PostDetailService {
  static String? baseUrl =  dotenv.env['BASE_URL_SML_3'];
  final _storage = FlutterSecureStorage();

  static const Map<String, String> _defaultHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Comment> addComment({
    required String userId,
    required String postId,
    required String content,
  }) async {
    try{
      final response = await http.post(
        Uri.parse("$baseUrl/comments/create/$userId"),
        headers: _defaultHeaders,
        body: json.encode({
          "postId":  postId,
          "content": content,
        })
      );
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        final result = Comment.fromJson(dataResponse['data']);
        return result;
      }else{
        throw Exception("Error add comment at postServiceDetail: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error funciton add comment at postServiceDetail: $e");
    }
  }

  Future<Map<String,dynamic>> toggleLiked({
    required String userId,
    required String postId
  }) async {
    try{
      final response = await http.post(
        Uri.parse("$baseUrl/likes/toggle-like"),
        headers: _defaultHeaders,
        body: json.encode({
          "userId": userId,
          "postId": postId
        })
      );
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        Map<String,dynamic> result = dataResponse;
        return result;
      }else{
        throw Exception("Error at toggle like: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at toggle like: $e");
    }
  }

  Future<Map<String,dynamic>> checkLiked({
    required String userId,
    required String postId
  }) async {
    try{
      final response = await http.get(
        Uri.parse("$baseUrl/likes/check-like?userId=$userId&postId=$postId"),
        headers: _defaultHeaders,
      );
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        final Map<String,dynamic> checkLiked = dataResponse;
        return checkLiked;
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
      final response = await http.delete(
        Uri.parse("$baseUrl/comments/delete/$commentId"),
        headers: _defaultHeaders,
      );
      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        final Map<String,dynamic> result = dataResponse;
        return result;
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
      final response = await http.put(
        Uri.parse("$baseUrl/comments/update/$commentId"),
        headers: _defaultHeaders,
        body: json.encode({
          "content": content
        })
      );
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