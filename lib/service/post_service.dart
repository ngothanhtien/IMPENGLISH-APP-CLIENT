import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/model/post/post_detail_response.dart';
import 'package:learning_app_client/model/post/post_response.dart';
import 'package:learning_app_client/service/request_auth.dart';

class PostService {
  static String? baseUrl =  dotenv.env['BASE_URL_SML_3'];
  final _storage = FlutterSecureStorage();

  static const Map<String, String> _defaultHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  Future<List<Post>> fetchPosts () async {
    try{
      String? token = await _storage.read(key: 'accessToken');

      final headers = {
        ..._defaultHeaders,
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: headers,
      );

      if(response.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final postResponse = PostResponse.fromJson(jsonData);
        return postResponse.data ?? [];
      }else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    }catch(e){
      throw Exception("Error at fetch post: $e");
    }
  }

  Future<Map<String,dynamic>> createPost({required Post post}) async {
    try{
      final body = {
        "title" : post.title ?? '',
        "category": post.category ?? '',
        "content": post.content ?? '',
        "tags": post.tags ?? [],
      };

      final response  = await requestWithAuth((token) async {
        return await http.post(
            Uri.parse("$baseUrl/posts/create"),
            headers: {
              "Content-type": "Application/json",
              "Authorization": "Bearer $token"
            },
            body: json.encode(body)
        );
      });

      if(response.statusCode == 200){
        final dataResponse = json.decode(response.body);
        return dataResponse;
      }else{
        throw Exception("Failed with status ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Error at fetch post: $e");
    }
  }

  Future<PostDetailResponse> getPostDetail({required String postId}) async {
    try{
      final response = await http.get(
        Uri.parse("$baseUrl/posts/detail/$postId"),
        headers: _defaultHeaders
      );

      if(response.statusCode == 200){
        final dataJson = json.decode(response.body);
        final detailPost = PostDetailResponse.fromJson(dataJson);
        if(detailPost.data != null){
          return detailPost;
        }else{
          throw Exception('Data is null');
        }
      }else {
        throw Exception('Failed to create posts: ${response.statusCode}');
      }
    }catch(e){
      throw Exception("Error at fetch post: $e");
    }
  }
}