import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  Map<String,dynamic>? user;
  final storage = FlutterSecureStorage();

  Future<void> _addComment() async {
    if(_controller.text.isEmpty){
      AppSnackBar.showError(context, "Please fill content before comment!");
      return;
    }
    try{
      final response = await PostDetailService().addComment(
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
          postId: widget.postId,
        );

        if (res['status'] == 'Success') {
          setState(() {
            isCheckliked = !isCheckliked;
            postCard = postCard?.copyWith(
              countLike: (postCard?.countLike ?? 0) + (isCheckliked ? 1 : -1)
            );
          });

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

  void unlockComment(CommentUI cmt) {
    setState(() {
      cmt.isEditing = !cmt.isEditing;
    });
  }

  void loadDataStorage() async {
    String? jsonString = await storage.read(key: 'user');

    if(jsonString !=null){

      Map<String,dynamic> data = jsonDecode(jsonString);
      setState(() {
        user = data;
      });
      debugPrint("$user");
    }else{
      debugPrint("No user data in storage");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailPost();
    checkLiked();
    loadDataStorage();
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
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: const Color(0xFF4F46E5),
      ),
      body: postCard == null
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5)))
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
              avatar: postCard?.userId?.avatar ?? '',
            ),
          ),

          const SizedBox(height: 8),

          // Comments header
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4F46E5).withValues(alpha: 0.1),
                  const Color(0xFF7C3AED).withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4F46E5),
                        Color(0xFF7C3AED),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.comment_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "${commentUIList.length} ${commentUIList.length == 1 ? 'Comment' : 'Comments'}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort_rounded,
                        color: Colors.grey.shade600,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Latest",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
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
              padding: const EdgeInsets.all(16),
              itemCount: commentUIList.length,
              itemBuilder: (context, index) {
                final item = commentUIList[index];
                final comment = item.data;
                final isOwner = user?["_id"] == comment.userId?.id;
                return _buildCommentCard(item,comment,isOwner);
              },
            ),
          ),

          // Comment input box
          _buildCommentInput(),
        ],
      ),
    );
  }
  Widget _buildCommentCard(CommentUI item, Comment comment, bool isOwner) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isEditing
              ? const Color(0xFF4F46E5).withValues(alpha: 0.3)
              : Colors.grey.shade200,
          width: item.isEditing ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar with gradient border
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4F46E5),
                      const Color(0xFF7C3AED),
                    ],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2.3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: user!['avatar'].toString().isNotEmpty ? null :
                    const Color(0xFF4F46E5),
                    backgroundImage: user!['avatar'].toString().isNotEmpty ?
                    NetworkImage(user!['avatar'].toString()) : null,
                    child: user!['avatar'].toString().isNotEmpty ? null : Text(
                      comment.userId?.fullName?[0].toUpperCase() ?? '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.userId?.fullName ?? "Anonymous",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                            letterSpacing: -0.3,
                          ),
                        ),
                        if (isOwner) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF4F46E5).withValues(alpha: 0.15),
                                  const Color(0xFF7C3AED).withValues(alpha: 0.15),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Text(
                              "You",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comment.createdAt?.toString().split(" ")[0] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomPopupMenu(
                isOwner: isOwner,
                onEdit: () => unlockComment(item),
                onDelete: () => deleteComment(comment.id as String),
                onReport: () => debugPrint("Report tapped"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: item.isEditing
                ? const EdgeInsets.all(12)
                : EdgeInsets.zero,
            decoration: item.isEditing
                ? BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
              ),
            )
                : null,
            child: TextField(
              controller: item.controller,
              enabled: item.isEditing,
              maxLines: null,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: item.isEditing
                    ? Colors.black87
                    : const Color(0xFF282E39),
                fontWeight: item.isEditing
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: item.isEditing ? "Edit your comment..." : null,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13
                ),
              ),
            ),
          ),
          if (item.isEditing) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      item.controller.text = item.data.content ?? '';
                      item.isEditing = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => updateComment(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4F46E5),
                            Color(0xFF7C3AED),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: user!['avatar'].toString().isNotEmpty ? null :
                const Color(0xFF4F46E5),
                backgroundImage: user!['avatar'].toString().isNotEmpty ?
                NetworkImage(user!['avatar'].toString()) : null,
                child: user!['avatar'].toString().isNotEmpty ? null : Text(
                  user!['fullName']?.fullName?[0].toUpperCase() ?? 'Y',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  cursorColor: Colors.red,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                  decoration: InputDecoration(
                    hintText: "Add a comment...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 5
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4F46E5),
                      Color(0xFF7C3AED),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      _addComment();
                    });
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.white,size: 22,),
                ),
              )
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