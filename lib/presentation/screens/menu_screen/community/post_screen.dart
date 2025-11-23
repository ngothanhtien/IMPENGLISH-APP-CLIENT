import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/textfield/CustomTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';
import 'package:learning_app_client/component/widgets/category_list_card.dart';
class Post_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Post_Screen();
}

class _Post_Screen extends State<Post_Screen>{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  List<String> listTag = [];
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Grammar",
      "icon": FontAwesomeIcons.bookOpen,
      "color": Colors.pinkAccent,
    },
    {
      "title": "Vocabulary",
      "icon": FontAwesomeIcons.spellCheck,
      "color": Colors.blueAccent,
    },
    {
      "title": "Pronunciation",
      "icon": FontAwesomeIcons.microphone,
      "color": Colors.purpleAccent,
    },
    {
      "title": "Business",
      "icon": FontAwesomeIcons.briefcase,
      "color": Colors.orangeAccent,
    },
    {
      "title": "Travel",
      "icon": FontAwesomeIcons.plane,
      "color": Colors.lightBlueAccent,
    },
    {
      "title": "Culture",
      "icon": FontAwesomeIcons.globe,
      "color": Colors.greenAccent,
    },
    {
      "title": "Tips & Tricks",
      "icon": FontAwesomeIcons.lightbulb,
      "color": Colors.amberAccent,
    },
    {
      "title": "Other",
      "icon": FontAwesomeIcons.commentDots,
      "color": Colors.grey,
    },
  ];
  String categorySeleted = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: Text("Create Post",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: ()=> context.pop(),
        ),
        actions: [
          ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text("Publish",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            )
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Container(
            padding: EdgeInsets.all(8),
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
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: double.infinity,
                  child: Text('0/100',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                 ),
                SizedBox(height: 12,),
                const Text("Category",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2
                  ),
                ),
                SizedBox(height: 12,),
                CategorySelector(
                  categories: categories,
                  onSelected: (value) => {
                    setState(() {
                      categorySeleted = value;
                    })
                  },
                ),
                SizedBox(height: 20,),
                const Text("Content",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, 2),
                        blurRadius: 10,
                      )
                    ]
                  ),
                  child: TextField(
                    expands: true, // mở rộng hết phần chiều cao có sẵn
                    maxLines: null,
                    minLines: null,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    controller: contentController,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "Write your comment here...",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF3D5CFF), width: 1.4),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFF858597),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: Text('0/1000',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        nameTextField: "Tags (Optional)",
                        hintText: "Add tag (max 5)...",
                        controller: tagController,
                        isPassword: false,
                        titleColor: const Color(0xFF1E293B),
                        titleSize: 16,
                        prefixIcon: Icons.tag,
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      height: 55,
                      width: 65,
                      child: ElevatedButton(
                        onPressed: (){
                          if(listTag.length > 5){
                            AppSnackBar.showError(context, "Tags were max!");
                            return;
                          }
                          setState(() {
                            if(tagController.text.toString().isNotEmpty){
                              listTag.add(tagController.text.toString());
                              tagController.clear();
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4F46E5),
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            )
                        ),
                        child: Text("Add",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: List.generate(listTag.length, (index){
                    String tag = listTag[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 5,top: 5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('#${tag}',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 4,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                listTag.remove(tag);
                              });
                            },
                            child: Icon(Icons.close,color: Colors.redAccent,size: 22,)
                          )
                        ],
                      )
                    );
                  }),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 4
                      )
                    ],
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add to your post",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: ListTile(
                                leading: Icon(Icons.image,size: 24,),
                                title: Text("Image",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            )
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.link,size: 24,),
                                  title: Text("Link",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Comming soon!",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}