import 'package:learning_app_client/model/pagination.dart';

class CardVocabulary {
  bool? success;
  String? message;
  List<IVocabBrief>? data;
  Pagination? pagination;
  CardVocabulary({this.success, this.message, this.data,this.pagination});

  CardVocabulary.fromJson(Map<String,dynamic> json){
    success = json['success'];
    message = json['message'];
    if(json['data'] != null){
      data = <IVocabBrief>[];
      json['data'].forEach((vocab) => {
        data!.add(IVocabBrief.fromJson(vocab))
      });
    }
    pagination = json['pagination'] !=null ? Pagination.fromJson(json['pagination']) : null;
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if(this.data != null){
      data['data'] = this.data!.map((vocab) => vocab.toJson()).toList();
    }
    if(pagination != null){
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}
class IVocabBrief {
  String? id;
  String? word;
  String? meaningVN;
  String? pronunciation;
  String? audio;
  String? definition;
  String? example;
  String? level;
  String? topic;
  String? partOfSpeech;

  IVocabBrief({
    this.id,
    this.word,
    this.meaningVN,
    this.pronunciation,
    this.audio,
    this.definition,
    this.example,
    this.level,
    this.topic,
    this.partOfSpeech
  });

  IVocabBrief.fromJson(Map<String,dynamic> json){
    id = json['id'];
    word = json['word'];
    meaningVN = json['meaningVN'];
    pronunciation = json['pronunciation'];
    audio = json['audio'];
    definition = json['definition'];
    example = json['example'];
    level = json['level'];
    topic = json['topic'];
    partOfSpeech = json['partOfSpeech'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['word'] = word;
    data['meaningVN'] = meaningVN;
    data['pronunciation'] = pronunciation;
    data['audio'] = audio;
    data['definition'] = definition;
    data['example'] = example;
    data['level'] = level;
    data['topic'] = topic;
    data['partOfSpeech'] = partOfSpeech;
    return data;
  }
}