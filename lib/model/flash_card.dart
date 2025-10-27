import 'package:learning_app_client/model/pagination.dart';

class Card_Vocabulary {
  bool? success;
  String? message;
  List<IVocabBrief>? data;
  Pagination? pagination;
  Card_Vocabulary({this.success, this.message, this.data,this.pagination});

  Card_Vocabulary.fromJson(Map<String,dynamic> json){
    success = json['success'];
    message = json['message'];
    if(json['data'] != null){
      data = <IVocabBrief>[];
      json['data'].forEach((vocab) => {
        data!.add(new IVocabBrief.fromJson(vocab))
      });
    }
    pagination = json['pagination'] !=null ? new Pagination.fromJson(json['pagination']) : null;
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if(this.data != null){
      data['data'] = this.data!.map((vocab) => vocab.toJson()).toList();
    }
    if(this.pagination != null){
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}
class IVocabBrief {
  String? id;
  String? word;
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
    pronunciation = json['pronunciation'];
    audio = json['audio'];
    definition = json['definition'];
    example = json['example'];
    level = json['level'];
    topic = json['topic'];
    partOfSpeech = json['partOfSpeech'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['word'] = word;
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