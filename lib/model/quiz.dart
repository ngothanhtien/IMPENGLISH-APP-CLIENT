class Quiz {
  String? status;
  String? message;
  List<Data>? data;

  Quiz({this.status,this.message,this.data});

  Quiz.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message'];
    if(json['data'] != null){
      data = <Data>[];
      json['data'].forEach((d){
        data!.add(new Data.fromJson(d));
      });
    }
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? topic;
  List<Question>? question;
  Data({this.id,this.topic,this.question});

  Data.fromJson(Map<String,dynamic> json){
    id = json['_id'];
    topic = json['topic'];
    if(json['question'] != null){
      question = <Question>[];
      json['question'].forEach((q){
        question!.add(new Question.fromJson(q));
      });
    }
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['_id'] = id;
    data['topic'] = topic;
    if(question != null){
      data['question'] = question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question{
  String? questionText;
  List<String>? options;
  String? correctAnswer;
  String? level;
  String? qsId;

  Question({this.questionText,this.options,this.level,this.correctAnswer,this.qsId});

  Question.fromJson(Map<String,dynamic> json) {
    questionText = json['questionText'];
    options = List<String>.from(json['options']);
    correctAnswer = json['correctAnswer'];
    level = json['level'];
    qsId = json['_id'];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['questionText'] = questionText;
    data['options'] = options;
    data['correctAnswer'] = correctAnswer;
    data['level'] = level;
    data['_id'] = qsId;
    return data;
  }
}