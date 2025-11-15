import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocab_detail.freezed.dart';
part 'vocab_detail.g.dart';

@freezed
class VocabDetailResponse with _$VocabDetailResponse {
  const factory VocabDetailResponse({
    String? title,
    String? message,
    @JsonKey(name: "detail") IVocabDetail? detail,
  }) = _VocabDetailResponse;

  factory VocabDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$VocabDetailResponseFromJson(json);
}

@freezed
class IVocabDetail with _$IVocabDetail {
  const factory IVocabDetail({
    @JsonKey(name: '_id') String? id,
    String? word,
    String? level,
    String? meaningVN,
    List<IDefinitions>? meanings,
    List<IPhonetic>? phonetics,
    String? topic,
  }) = _IVocabDetail;

  factory IVocabDetail.fromJson(Map<String, dynamic> json) =>
      _$IVocabDetailFromJson(json);
}

@freezed
class IPhonetic with _$IPhonetic {
  const factory IPhonetic({
    String? text,
    String? audio,
  }) = _IPhonetic;

  factory IPhonetic.fromJson(Map<String, dynamic> json) =>
      _$IPhoneticFromJson(json);
}

@freezed
class IDefinitions with _$IDefinitions {
  const factory IDefinitions({
    String? partOfSpeech,
    List<IDefinition>? definitions,
  }) = _IDefinitions;

  factory IDefinitions.fromJson(Map<String, dynamic> json) =>
      _$IDefinitionsFromJson(json);
}

@freezed
class IDefinition with _$IDefinition {
  const factory IDefinition({
    String? definition,
    String? example,
  }) = _IDefinition;

  factory IDefinition.fromJson(Map<String, dynamic> json) =>
      _$IDefinitionFromJson(json);
}
