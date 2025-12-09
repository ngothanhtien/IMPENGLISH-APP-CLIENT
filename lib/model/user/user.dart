import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "_id") String? userId,
    String? email,
    String? fullName,
    String? phone,
    String? provider,
    String? googleId,
    String? avatar,
    int? streakDay,
    String? level,
    bool? verify,
    bool? status,
    String? type,

    // Parse DateTime
    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
    DateTime? createdAt,

    @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
    DateTime? updatedAt,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
DateTime? _fromJsonDate(String? date) =>
    date == null ? null : DateTime.parse(date);

String? _toJsonDate(DateTime? date) => date?.toIso8601String();