import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/custom_textfield.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/forum_postcard.dart';
import 'package:learning_app_client/component/widgets/popupmenu_custom.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/model/post/post_detail_response.dart';
import 'package:learning_app_client/service/post_detail_service.dart';
import 'package:learning_app_client/service/post_service.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  const PostDetailScreen({super.key,required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<CommentUI> commentUIList = [];
  Post? postCard;
  bool isCheckliked = false;
  bool isLiking = false;

  Timer? _debounceLike;
  Timer? _debounceCheck;

  Future<void> _addComment() async {
    if(_controller.text.isEmpty){
      AppSnackBar.showError(context, "Please fill content before comment!");
      return;
    }
    try{
      final response = await PostDetailService().addComment(
        userId: '6922c97f156b0b58fefdc55f',
        content: _controller.text,
        postId: widget.postId
      ).timeout(Duration(seconds: 4));
      setState(() {
        // comments?.add(response);
        commentUIList.add(CommentUI(data: response));
        _controller.clear();
      });
    }catch(e){
      debugPrint("Error at add comment: $e");
    }
  }

  Future<void> fetchDetailPost() async {
    try {
      final response = await PostService().getPostDetail(postId: widget.postId);

      if (response.status == "Success") {
        setState(() {
          postCard = response.data!.post;
          // comments = List<Comment>.from(response.data!.comments as Iterable);
          commentUIList = response.data!.comments!.map((cmt) => CommentUI(data: cmt)).toList();
        });
      }
    } catch (e) {
      debugPrint("Error fetchDetailPost: $e");
    }
  }

  Future<void> toggleLike() async {
    if (isLiking) return; // chặn spam click

    isLiking = true;

    // Debounce 300ms
    _debounceLike?.cancel();
    _debounceLike = Timer(const Duration(milliseconds: 300), () async {

      try {
        final res = await PostDetailService().toggleLiked(
          userId: '6922c97f156b0b58fefdc55f',
          postId: widget.postId,
        );

        if (res['status'] == 'Success') {
          // Cập nhật UI tức thời – không cần fetch Detail
          setState(() {
            isCheckliked = !isCheckliked;
            postCard = postCard?.copyWith(
              countLike: (postCard?.countLike ?? 0) + (isCheckliked ? 1 : -1)
            );
          });

          // Nếu muốn đồng bộ server → gọi checkLiked() (debounce)
          checkLiked();
        }
      } catch (e) {
        debugPrint("Error like: $e");
      } finally {
        isLiking = false;
      }
    });
  }
  Future<void> checkLiked() async {
    _debounceCheck?.cancel();
    _debounceCheck = Timer(const Duration(milliseconds: 400), () async {
      try {
        final res = await PostDetailService().checkLiked(
          userId: '6922c97f156b0b58fefdc55f',
          postId: widget.postId,
        );

        setState(() {
          isCheckliked = res["liked"] == true;
        });
      } catch (e) {
        debugPrint("Error checkLiked: $e");
      }
    });
  }
  Future<void> deleteComment(String commentId) async {
    try{
      final response = await PostDetailService().deleteComment(
          commentId: commentId,
      );

      if(!mounted) return;

      if(response['status'] == 'Success'){
        await Future.delayed(Duration(milliseconds: 800));

        if(!mounted) return;

        AppSnackBar.showSuccess(context, "Delete comment successfull");
        fetchDetailPost();
      }
    }catch(e){
      debugPrint("Error delete comment: $e");
    }
  }
  void unlockComment(CommentUI cmt) {
    setState(() {
      cmt.isEditing = !cmt.isEditing;
    });
  }
  Future<void> updateComment(CommentUI cmt) async{
    final newContent = cmt.controller.text.trim();

    if(newContent.isEmpty){
      AppSnackBar.showError(context, "Please fill content before update!");
      return;
    }
    try{
      final response = await PostDetailService().updateComment(
          commentId: cmt.data.id!,
          content: newContent
      );
      if(response['status'] == 'Success'){
        setState(() {
          cmt.data = cmt.data.copyWith(content: newContent);
          cmt.isEditing = false;
        });
      }
    }catch(e){
      debugPrint("Error delete comment: $e");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailPost();
    checkLiked();
  }
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _controllerContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "Discussion",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: Color(0xFF1F2937),
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E7EA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1F2937),
              size: 18,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: postCard == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Post content
          Container(
            color: Colors.white,
            child: ForumPostCard(
              fullName: postCard?.userId?.fullName ?? '',
              streakDay: postCard?.userId?.streakDay ?? 0,
              likes: postCard?.countLike ?? 0,
              date: postCard?.createdAt?.toString().split(' ')[0] ?? '',
              category: postCard?.category ?? '',
              content: postCard?.content ?? '',
              level: postCard?.userId?.level ?? '',
              title: postCard?.title ?? '',
              id: postCard?.id ?? '',
              tags: postCard?.tags ?? [],
              countComments: commentUIList.length,
              isCheckLike: toggleLike,
              isLiked: isCheckliked,
            ),
          ),

          const SizedBox(height: 8),

          // Comments header
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "${commentUIList.length} Comments",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                    height: 1.5
                  ),
                ),
                const Spacer(),
                const Icon(Icons.sort_rounded, color: Color(0xFF6B7280))
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Comments list
          Expanded(
            child: commentUIList.isEmpty
                ? const Center(
              child: Text(
                "No comments yet.",
                style: TextStyle(color: Colors.grey,fontSize: 14),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: commentUIList.length,
              itemBuilder: (context, index) {
                final item = commentUIList[index];
                final comment = item.data;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFF4F46E5),
                        child: Text(
                          comment.userId?.fullName?[0].toUpperCase() ?? '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  comment.userId?.fullName ?? "Anonymous",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  comment.createdAt?.toString().split(" ")[0] ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8C929A),
                                  ),
                                ),
                                SizedBox(width: 12,),
                                CustomPopupMenu(
                                  isOwner: '6922c97f156b0b58fefdc55f' == comment.userId?.id,
                                  onEdit: () => unlockComment(item),
                                  onDelete: () => deleteComment(comment.id as String),
                                  onReport: () => debugPrint("Report tapped")
                                )
                              ],
                            ),
                            TextField(
                              controller: item.controller,
                              enabled: item.isEditing,
                              maxLines: null,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Colors.black87
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: item.isEditing ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(width: 0.8,color: Colors.black26)
                                ): null,
                                contentPadding:
                                item.isEditing ? EdgeInsets.only(left: 5)
                                    : EdgeInsets.zero,
                              ),
                            ),
                            if (item.isEditing)
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        item.controller.text = item.data.content ?? '';
                                        item.isEditing = false;
                                      });
                                    },
                                    child: const Text("Cancel",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  ElevatedButton(
                                    onPressed: () => updateComment(item),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                    child: const Text("Save",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Comment input box
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF4F46E5),
                child: Text(
                  "Y",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomTextField(
                  hintText: "Add a comment ...",
                  controller: _controller,
                  isPassword: false,
                  showTitle: false,
                ),
              ),
              const SizedBox(width: 2),
              IconButton(
                onPressed: (){
                  setState(() {
                    _addComment();
                  });
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                ),
                icon: const Icon(Icons.send_rounded, color: Colors.white,size: 20,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CommentUI {
  Comment data;
  final TextEditingController controller;
  bool isEditing = false;

  CommentUI({required this.data})
      : controller = TextEditingController(text: data.content);
}