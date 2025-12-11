import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_app_client/service/auth_service.dart';

final storage = FlutterSecureStorage();

Future<http.Response> requestWithAuth(
    Future<http.Response> Function(String token) requestFn,
    ) async {

  final accessToken = await storage.read(key: 'accessToken');

  // Gửi request lần đầu
  http.Response response = await requestFn(accessToken ?? "");

  // Nếu lỗi token hết hạn
  if (response.statusCode == 401) {
    final body = json.decode(response.body);

    if (body['error'] == "Unauthorized") {
      // Thử refresh token
      final newToken = await AuthService().refreshToken();

      if (newToken == null) {
        // Refresh token cũng hết → logout
        await AuthService().logOut();
        throw Exception("Session expired. Please login again.");
      }

      // Gửi lại request lần 2
      response = await requestFn(newToken);
    }
  }
  return response;
}

