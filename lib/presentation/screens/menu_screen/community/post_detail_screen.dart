import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/forum_postcard.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/model/post/post_detail_response.dart';
import 'package:learning_app_client/service/postService.dart';

class PostDetailScreen extends StatefulWidget {
  final String post_id;
  const PostDetailScreen({super.key,required this.post_id});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final List<Map<String, dynamic>> _comments = [
    {
      "text": "This is really helpful, thanks!",
      "author": "Sarah Johnson",
      "time": "2 hours ago",
      "likes": 12,
      "isLiked": false,
    },
    {
      "text": "I recommend using podcasts for listening practice.",
      "author": "Mike Chen",
      "time": "5 hours ago",
      "likes": 8,
      "isLiked": false,
    },
    {
      "text": "Try reading business articles daily.",
      "author": "Emma Wilson",
      "time": "1 day ago",
      "likes": 15,
      "isLiked": false,
    },
  ];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Comment>? comments;
  Post? postCard;

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _comments.insert(0, {
          "text": text,
          "author": "You",
          "time": "Just now",
          "likes": 0,
          "isLiked": false,
        });
        _controller.clear();
      });
      _focusNode.unfocus();
    }
  }

  void _toggleLike(int index) {
    setState(() {
      _comments[index]["isLiked"] = !_comments[index]["isLiked"];
      _comments[index]["likes"] += _comments[index]["isLiked"] ? 1 : -1;
    });
  }

  Future<void> fetchDetailPost() async {
    try{
      final response = await postService().getPostDetail(postId: widget.post_id.toString());
      if(response.status == "Success"){
        setState(() {
          postCard = response.data!.post;
          comments = response.data!.comments;
        });
      }else{
        print("fetch detail post error!!");
      }
      setState(() {

      });
    }catch(e){
      print("Error at fetch detail post!: $e");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailPost();
  }
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
            color: Color(0xFF1F2937),
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1F2937),
              size: 22,
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
            ),
          ),

          const SizedBox(height: 8),

          // Comments header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "${comments?.length ?? 0} Comments",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.sort_rounded, color: Color(0xFF6B7280))
              ],
            ),
          ),

          // Comments list
          Expanded(
            child: comments == null
                ? const Center(child: CircularProgressIndicator())
                : comments!.isEmpty
                ? const Center(
              child: Text(
                "No comments yet.",
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                final comment = comments![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFF4F46E5),
                        child: Text(
                          comment.userId?[0].toUpperCase() ?? '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
                                  comment.userId ?? "Anonymous",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  comment.createdAt?.toString().split(" ")[0] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              comment.content ?? '',
                              style: const TextStyle(fontSize: 16, height: 1.4),
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
            color: Colors.black.withOpacity(0.05),
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
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF4F46E5),
                child: Text(
                  "Y",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: "Add a comment...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _addComment,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                ),
                icon: const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}