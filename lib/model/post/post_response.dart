import 'package:freezed_annotation/freezed_annotation.dart';
import 'post.dart'; // ✅ tái sử dụng Post

part 'post_response.freezed.dart';
part 'post_response.g.dart';

@freezed
class PostResponse with _$PostResponse {
  const factory PostResponse({
    String? status,
    int? total,
    List<Post>? data,
  }) = _PostResponse;

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);
}