
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static String? baseUrl =  dotenv.env['BASE_URL_SML_3'];
  
  final storage = FlutterSecureStorage();

  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<Map<String,dynamic>> login({
    required String email,
    required String password
  }) async {
    try{
      final body = json.encode({
        'email': email.trim(),
        'password': password.trim()
      });

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 10));

        final data = json.decode(response.body);

        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];
        final user = data['user'];

        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);
        await storage.write(key: 'user', value: json.encode(user));

        return json.decode(response.body);
    }catch(e){
      throw Exception("Error in processing login: $e");
    }
  }

  Future<Map<String, dynamic>?> logOut() async {
    try {
      final refreshToken = await storage.read(key: "refreshToken");

      if (refreshToken == null) return null;

      final response = await http.post(
        Uri.parse("$baseUrl/auth/logout"),
        headers: {
          "Content-type": "application/json",
        },
        body: json.encode({ 'refreshToken': refreshToken }),
      ).timeout(const Duration(seconds: 8));

      final data = response.body.isNotEmpty ? json.decode(response.body) : {};

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Xóa token local
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        return data;
      } else {
        final msg = data['message'] ?? 'Logout failed with status ${response.statusCode}';
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception("Error in logOut: $e");
    }
  }

  Future<String?> refreshToken() async {
    try{
      final refreshToken = await storage.read(key: "refreshToken");

      if (refreshToken == null) return null;

      final response = await http.post(
        Uri.parse("$baseUrl/auth/refresh-token"),
        headers: headers,
        body: json.encode({ "refreshToken": refreshToken }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storage.write(key: 'accessToken', value: data['accessToken']);
        await storage.write(key: 'refreshToken', value: data['refreshToken']);

        return data['accessToken'];
      }

      return null;
    }catch(e){
      throw Exception("Error at refreshToken: $e");
    }
  }
}