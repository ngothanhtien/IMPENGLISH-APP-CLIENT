import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/CustomTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/component/widgets/category_list_card.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/service/postService.dart';

class Post_Screen extends StatefulWidget {
  @override
  State<Post_Screen> createState() => _Post_Screen();
}

class _Post_Screen extends State<Post_Screen> {
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

    if (listTags.length > 5) {
      AppSnackBar.showError(context, "You can only add up to 5 tags!");
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
      userId: UserPost(id: "68cd5981cf94a9641d3e9391"),
    );
    try{
      final response = await postService().createPost(post: post).timeout(Duration(seconds: 5));
      await Future.delayed(const Duration(milliseconds: 1500));
      if(response != null){
        setState(() {
          isLoading = false;
          resetAll();
        });
        AppSnackBar.showSuccess(context, "Post created successfully!");
      }
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() => isLoading = false);
      print("Error at create post screen: $e");
      AppSnackBar.showError(context, "Failed to create post!");
    }
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
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
        actions: [
          ElevatedButton(
            onPressed: _onPublish,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
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
              padding: const EdgeInsets.all(8),
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
                    prefixIcon: Icons.title,
                    onchanged: (value) {
                      setState(() => titleCount = value.length);
                    },
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$titleCount/100",
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16, color: Color(0xFF1E293B), fontWeight: FontWeight.w700),
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

                  const Text(
                    "Content",
                    style: TextStyle(fontSize: 16, color: Color(0xFF1E293B), fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: Offset(0, 2),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: TextField(
                      controller: contentController,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      style: const TextStyle(fontSize: 16),
                      onChanged: (value) {
                        setState(() => contentCount = value.length);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Write your content here...",
                        hintStyle: const TextStyle(color: Color(0xFF858597),fontSize: 15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 1,color: Colors.black26)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 1.3,color: const Color(0xFF4F46E5))
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$contentCount/1000",
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          nameTextField: "Tags (Optional)",
                          hintText: "Add tag (max 5)...",
                          controller: tagController,
                          isPassword: false,
                          prefixIcon: Icons.tag,
                          titleSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),

                      SizedBox(
                        height: 55,
                        width: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            if (listTags.length >= 5) {
                              AppSnackBar.showError(context, "Max 5 tags allowed!");
                              return;
                            }

                            if (tagController.text.trim().isEmpty) return;

                            setState(() {
                              listTags.add(tagController.text.trim());
                              tagController.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text("Add", style: TextStyle(color: Colors.white,fontSize: 13)),
                        ),
                      )
                    ],
                  ),

                  Wrap(
                    spacing: 6,
                    children: listTags.map((tag) {
                      return Chip(
                        label: Text("#$tag", style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue.shade600,
                        deleteIcon: const Icon(Icons.close, color: Colors.white),
                        onDeleted: () {
                          setState(() => listTags.remove(tag));
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  _buildAddToPostSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if(isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 3,),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddToPostSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 4),
            blurRadius: 4,
          )
        ],
        border: Border.all(color: Colors.black26,width: 0.5,)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Add to your post",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildAddCard(Icons.image, "Image")),
              const SizedBox(width: 12),
              Expanded(child: _buildAddCard(Icons.link, "Link")),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Coming soon!", style: TextStyle(color: Colors.black54)),
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
}
