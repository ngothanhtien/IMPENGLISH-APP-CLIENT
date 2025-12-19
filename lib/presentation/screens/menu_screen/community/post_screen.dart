import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/custom_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_app_client/component/topsnackbar/show_top_snack_bar.dart';
import 'package:learning_app_client/component/widgets/category_list_card.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/service/post_service.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreen();
}

class _PostScreen extends State<PostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  List<String> listTags = [];
  bool isLoading = false;
  String categorySelected = '';

  int titleCount = 0;
  int contentCount = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "Grammar", "icon": FontAwesomeIcons.bookOpen, "color": Colors.pinkAccent,
      "value": "grammar"
    },
    {"title": "Vocabulary", "icon": FontAwesomeIcons.spellCheck,
      "color": Colors.blueAccent,
      "value": "vocabulary"
    },
    {"title": "Pronunciation", "icon": FontAwesomeIcons.microphone,
      "color": Colors.purpleAccent,
      "value": "pronunciation"
    },
    {"title": "Business", "icon": FontAwesomeIcons.briefcase,
      "color": Colors.orangeAccent,
      "value": "business"
    },
    {"title": "Travel", "icon": FontAwesomeIcons.plane,
      "color": Colors.lightBlueAccent,
      "value": "travel"
    },
    {"title": "Culture", "icon": FontAwesomeIcons.globe,
      "color": Colors.greenAccent,
      "value": "grammar"
    },
    {"title": "Tips & Tricks", "icon": FontAwesomeIcons.lightbulb,
      "color": Colors.amberAccent,
      "value": "tips & tricks"
    },
    {"title": "Other", "icon": FontAwesomeIcons.commentDots,
      "color": Colors.grey,
      "value": "other"
    },
  ];

  bool _validateForm() {
    if (titleController.text.trim().isEmpty) {
      AppSnackBar.showError(context, "Title cannot be empty!");
      return false;
    }

    if (titleController.text.trim().length > 100) {
      AppSnackBar.showError(context, "Title exceeds 100 characters!");
      return false;
    }

    if (categorySelected.isEmpty) {
      AppSnackBar.showError(context, "Please select a category!");
      return false;
    }

    if (contentController.text.trim().isEmpty) {
      AppSnackBar.showError(context, "Content cannot be empty!");
      return false;
    }

    if (contentController.text.trim().length > 1000) {
      AppSnackBar.showError(context, "Content exceeds 1000 characters!");
      return false;
    }

    return true;
  }

  void resetAll(){
    titleController.clear();
    contentController.clear();
    tagController.clear();
    categorySelected = '';
    titleCount = 0;
    contentCount = 0;
    listTags.clear();
  }

  Future<void> _onPublish() async {
    if (!_validateForm()) return;
    setState(() {
      isLoading = true;
    });
    final post = Post(
      title: titleController.text,
      category: categorySelected,
      content: contentController.text,
      tags: listTags,
    );
    try{
      final response = await PostService().createPost(post: post).timeout(Duration(seconds: 5));

      await Future.delayed(const Duration(milliseconds: 1500));
      if(response['status'] == "Success"){
        setState(() {
          isLoading = false;
          resetAll();
        });
        if(!mounted) return;
        AppSnackBar.showSuccess(context, "Post created successfully!");
      }else {
        if(!mounted) return;
        AppSnackBar.showError(context, "Can't create post. Please try again!");
        setState(() {
          isLoading = false;
        });
      }
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1500));

      if(!mounted) return;
      setState(() => isLoading = false);

      debugPrint("Error at create post screen: $e");
      AppSnackBar.showError(context, "Failed to create post!");
    }
  }

  void addTag(){
    if(listTags.length >= 5){
      AppSnackBar.showError(context, "You can only add a maximum of 5 tags!");
      return;
    }

    if(tagController.text.trim().isEmpty) return;

    setState(() {
      listTags.add(tagController.text.trim());
      tagController.clear();
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
    tagController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text(
          "Create Post",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        leading: IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            padding: EdgeInsets.all(8),
            backgroundColor: Colors.white.withValues(alpha: 0.3)
          ),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: _onPublish,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: Icon(Icons.publish_rounded,size: 18,color: Colors.white,),
            label: const Text(
              "Publish",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    nameTextField: "Title",
                    hintText: "What's your question or topic?",
                    controller: titleController,
                    isPassword: false,
                    titleColor: const Color(0xFF1E293B),
                    titleSize: 16,
                    prefixIcon: Icons.edit_note_rounded,
                    onchanged: (value) {
                      setState(() => titleCount = value.length);
                    },
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$titleCount/100",
                      style: TextStyle(
                        color: titleCount > 100
                            ? Colors.red
                            : Colors.grey.shade600,
                        fontSize: 14
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildTitle(
                    Icons.category_rounded,
                    "Category"
                  ),
                  const SizedBox(height: 12),

                  CategorySelector(
                    categories: categories,
                    onSelected: (value) {
                      setState(() {
                        categorySelected = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildTitle(
                      Icons.article_rounded,
                      "Content"
                  ),

                  const SizedBox(height: 12),

                  Column(
                    children: [
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: contentController,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.black
                          ),
                          onChanged: (value) {
                            setState(() => contentCount = value.length);
                          },
                          decoration: InputDecoration(
                            hintText: "Share your thoughts, questions, or knowledge...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey,width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Color(0xFF4F46E5),width: 2.2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "$contentCount/1000",
                          style: TextStyle(
                            color: contentCount > 1000
                                ? Colors.red
                                : Colors.grey.shade600,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.5
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildTitle(
                      Icons.tag_rounded,
                      "Tags(max 5 tags)"
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: tagController,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              hintText: "Add a tag...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              prefixIcon: Icon(
                                Icons.tag_rounded,
                                color: Colors.grey.shade600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.grey,width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Color(0xFF4F46E5),width: 2.2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: addTag,
                          child: Container(
                            height: 56,
                            width: 80,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4F46E5),
                                  Color(0xFF7C3AED),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Wrap(
                    spacing: 6,
                    children: listTags.map((tag) {
                      return Chip(
                        label: Text("#$tag",
                          style: const TextStyle(
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          )
                        ),
                        backgroundColor: Color(0xFF4F46E5).withValues(alpha: 0.15),
                        deleteIcon: const Icon(Icons.close, color: Color(0xFF4F46E5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.6),
                            width: 1.5
                          )
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        onDeleted: () {
                          setState(() => listTags.remove(tag));
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  _buildComingSoonSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Publishing your post...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildComingSoonSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Add to your post",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAddCard(Icons.image_rounded, "Image"),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.amber.shade200,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  "Coming soon!",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard(IconData icon, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, size: 24),
        title: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildTitle(IconData icon,String title){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                  ]
              ),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8,),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
