
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app_client/model/user/user.dart';
import 'package:learning_app_client/service/request_auth.dart';

class UserService {
  static String? baseUrl = dotenv.env['BASE_URL_SML_3'];

  final storage = FlutterSecureStorage();
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  // đăng ký tài khoản
  Future<Map<String, dynamic>> signUp({
    required String fullName,
    required String email,
    required String password
  }) async {
    try {
      final body = json.encode({
        'fullName': fullName,
        'email': email,
        'password': password
      });

      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 10)); // Tăng timeout

      // Xử lý tất cả status codes
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        try {
          final errorBody = json.decode(response.body);
          return {
            'status': 'failed',
            'message': errorBody['message'] ?? 'Có lỗi xảy ra từ phía client',
            'statusCode': response.statusCode
          };
        } catch (e) {
          return {
            'status': 'failed',
            'message': 'Lỗi không xác định từ server (${response.statusCode})',
            'statusCode': response.statusCode
          };
        }
      } else if (response.statusCode >= 500) {
        // Server errors
        return {
          'status': 'failed',
          'message': 'Lỗi server, vui lòng thử lại sau',
          'statusCode': response.statusCode
        };
      } else {
        // Unexpected status codes
        return {
          'status': 'failed',
          'message': 'Phản hồi không mong đợi từ server',
          'statusCode': response.statusCode
        };
      }
    }catch(e){
      throw "Error create account: $e";
    }
  }

  // xác thực otp sau khi đăng ký
  Future<Map<String, dynamic>> veryfyOtp({
    required String email,
    required int otp
  }) async {
    try{
      final response = await http.post(
          Uri.parse('$baseUrl/users/verify-otp'),
          headers: headers,
          body: json.encode({
            'email': email,
            'otp': otp
          })
      );
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else {
        throw Exception('Failed to verify OTP: ${response.statusCode}');
      }
    }catch(e){
      throw Exception("Error verify otp: $e");
    }
  }

  Future<Map<String,dynamic>> resendOtp({
    required String email
  }) async {
    try{
      final response = await http.put(
        Uri.parse("$baseUrl/users/resend-otp"),
        headers: headers,
        body: json.encode({'email': email})
      );
      final data = json.decode(response.body);
      if(response.statusCode == 200){
        return data;
      }else {
        throw Exception(data['message'] ?? 'Resend OTP failed');
      }
    }catch(e){
      throw Exception("Error in process resending OTP: $e");
    }
  }

  Future<User> getProfile() async {
    try{
      final accessToken = await storage.read(key: "accessToken");

      if (accessToken == null) {
        throw Exception("Access token not found");
      }

      final response = await http.get(
        Uri.parse("$baseUrl/users/profile"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String,dynamic> data = json.decode(response.body);
        return User.fromJson(data['user']);
      }

      if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      }

      throw Exception("Error: ${response.statusCode}");
    }catch(e){
      throw Exception("Error in get profile: $e");
    }
  }

  Future<http.Response> updateProfile(Map<String,dynamic> data) async {
    return await requestWithAuth((token){
      return http.put(
        Uri.parse("$baseUrl/users/profile"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode(data)
      );
    });
  }

  Future<http.Response> changePassword({
    String? oldPassword,
    String? newPassword
  }) async {
    return await requestWithAuth((token){
      return http.put(
          Uri.parse("$baseUrl/users/change-password"),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode({
            "oldPassword": oldPassword,
            "newPassword": newPassword
          })
      );
    });
  }

  Future<String?> changeAvatar(File file) async {
    try {

      final response = await requestWithAuth((token) async {
        final url = Uri.parse("$baseUrl/upload/change-avatar");

        final request = http.MultipartRequest("PUT", url)
          ..headers["Authorization"] = "Bearer $token"
          ..headers["Content-Type"] = "multipart/form-data"
          ..files.add(await http.MultipartFile.fromPath(
            "file",
            file.path,
            filename: file.path.split('/').last,
          ));

        final res = await request.send();
        return await http.Response.fromStream(res);
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        debugPrint("✅ Avatar uploaded successfully: ${body['avatar']}");

        return body["avatar"]; // URL avatar từ backend
      } else {

        debugPrint("❌ Upload failed: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      // 👉 FIX 8: Bắt và log lỗi
      debugPrint("❌ Error in changeAvatar: $e");
      return null;
    }
  }
}