import 'package:freezed_annotation/freezed_annotation.dart';
import 'post.dart'; // ✅ tái sử dụng Post và UserPost

part 'post_detail_response.freezed.dart';
part 'post_detail_response.g.dart';

@freezed
class PostDetailResponse with _$PostDetailResponse {
  const factory PostDetailResponse({
    String? status,
    PostDetailData? data,
  }) = _PostDetailResponse;

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDetailResponseFromJson(json);
}

@freezed
class PostDetailData with _$PostDetailData {
  const factory PostDetailData({
    Post? post,
    List<Comment>? comments,
  }) = _PostDetailData;

  factory PostDetailData.fromJson(Map<String, dynamic> json) =>
      _$PostDetailDataFromJson(json);
}

@freezed
class  Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: '_id') String? id,
    String? postId,
    UserPost? userId,
    int? countLike,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
