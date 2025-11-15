// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VocabDetailResponseImpl _$$VocabDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$VocabDetailResponseImpl(
  title: json['title'] as String?,
  message: json['message'] as String?,
  detail:
      json['detail'] == null
          ? null
          : IVocabDetail.fromJson(json['detail'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$VocabDetailResponseImplToJson(
  _$VocabDetailResponseImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'message': instance.message,
  'detail': instance.detail,
};

_$IVocabDetailImpl _$$IVocabDetailImplFromJson(Map<String, dynamic> json) =>
    _$IVocabDetailImpl(
      id: json['_id'] as String?,
      word: json['word'] as String?,
      level: json['level'] as String?,
      meaningVN: json['meaningVN'] as String?,
      meanings:
          (json['meanings'] as List<dynamic>?)
              ?.map((e) => IDefinitions.fromJson(e as Map<String, dynamic>))
              .toList(),
      phonetics:
          (json['phonetics'] as List<dynamic>?)
              ?.map((e) => IPhonetic.fromJson(e as Map<String, dynamic>))
              .toList(),
      topic: json['topic'] as String?,
    );

Map<String, dynamic> _$$IVocabDetailImplToJson(_$IVocabDetailImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'word': instance.word,
      'level': instance.level,
      'meaningVN': instance.meaningVN,
      'meanings': instance.meanings,
      'phonetics': instance.phonetics,
      'topic': instance.topic,
    };

_$IPhoneticImpl _$$IPhoneticImplFromJson(Map<String, dynamic> json) =>
    _$IPhoneticImpl(
      text: json['text'] as String?,
      audio: json['audio'] as String?,
    );

Map<String, dynamic> _$$IPhoneticImplToJson(_$IPhoneticImpl instance) =>
    <String, dynamic>{'text': instance.text, 'audio': instance.audio};

_$IDefinitionsImpl _$$IDefinitionsImplFromJson(Map<String, dynamic> json) =>
    _$IDefinitionsImpl(
      partOfSpeech: json['partOfSpeech'] as String?,
      definitions:
          (json['definitions'] as List<dynamic>?)
              ?.map((e) => IDefinition.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$IDefinitionsImplToJson(_$IDefinitionsImpl instance) =>
    <String, dynamic>{
      'partOfSpeech': instance.partOfSpeech,
      'definitions': instance.definitions,
    };

_$IDefinitionImpl _$$IDefinitionImplFromJson(Map<String, dynamic> json) =>
    _$IDefinitionImpl(
      definition: json['definition'] as String?,
      example: json['example'] as String?,
    );

Map<String, dynamic> _$$IDefinitionImplToJson(_$IDefinitionImpl instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'example': instance.example,
    };
