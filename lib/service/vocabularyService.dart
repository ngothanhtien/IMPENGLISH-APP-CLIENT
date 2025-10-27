import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app_client/model/flash_card.dart';
class vocabService {
  final String? base_url = dotenv.env["BASE_URL_SML_3"];
  static Map<String,String> headers = {
    'Content-type': "application/json",
    'Accept': 'application/json'
  };

  Future<Card_Vocabulary> fetchVocabBrief({int page = 1, int limit = 10}) async {
    try{
      final response = await http.get(
        Uri.parse("${base_url}/vocabulary/flashCard"),
        headers: headers,
      );
      if(response.statusCode == 200){
        final jsondata = json.decode(response.body);
        return Card_Vocabulary.fromJson(jsondata);
      }else {
        throw Exception('Failed to load vocab. StatusCode: ${response.statusCode}');
      }
    }catch(e){
      throw Exception("Error at get Vocabulary brief: $e");
    }
  }
}