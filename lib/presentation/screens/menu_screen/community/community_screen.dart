
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/forum_postcard.dart';
import 'package:learning_app_client/model/post/post.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/leader_board_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/post_detail_screen.dart';
import 'package:learning_app_client/service/postService.dart';

class Community_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Community_Screen();
}
class _Community_Screen extends State<Community_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  List<Post> posts = [];
  bool isLoadingPost = true;

  Future<void> getListPost() async {
    setState(() {
      isLoadingPost = true;
    });
    try{
      final response = await postService().fetchPosts();
      setState(() {
        posts = response;
        isLoadingPost = false;
      });
    }catch(e){
      setState(() {
        isLoadingPost = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
    getListPost();
  }
  Widget _buildAnimatedTabContent(Widget child) {
    // hiệu ứng fade + slide nhẹ
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.1, 0), // trượt nhẹ sang trái/phải
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: child,
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF4F46E5),
          title: Text(
            'Community',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () => context.push('/community/post'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2
                ),
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              label: Text("Post",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700
                )
              ),
              icon: Icon(Icons.add,size: 22,color: Colors.white,),
            ),
            SizedBox(width: 10,),
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: TabBar(
                padding: EdgeInsets.all(10),
                controller: _tabController,
                labelColor: const Color(0xFF4F46E5),
                unselectedLabelColor: Colors.grey.shade500,
                labelStyle: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700
                ),
                tabs: [
                  Tab(
                    text: "Forum",
                  ),
                  Tab(
                    text: "LeaderBoard",
                  ),
                ]
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child,Animation<double> animation){
                  final slideAnimation = Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: slideAnimation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: IndexedStack(
                  key: ValueKey<int>(_currentIndex),
                  index: _currentIndex,
                  children: [
                    _buildAnimatedTabContent(
                      SingleChildScrollView(
                        key: const ValueKey('Forum'),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 14),
                                child: ElevatedButton(
                                  onPressed: getListPost,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4F46E5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                    )
                                  ),
                                  child: const Text("Reload",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                  )
                                ),
                              ),
                              SizedBox(height: 12,),
                              isLoadingPost ? Center(child: CircularProgressIndicator(),):
                              Column(
                                children: List.generate(posts.length, (index){
                                  final post = posts[index];
                                  return ForumPostCard(
                                    id: post.id ?? '',
                                    fullName: post.userId?.fullName ?? '',
                                    title: post.title ?? '',
                                    level: post.userId?.level ?? '',
                                    content: post.content ?? '',
                                    category: post.category ?? '',
                                    date: post.createdAt.toString() ?? '',
                                    likes: post.countLike ?? 0,
                                    streakDay: post.userId?.streakDay ?? 0,
                                    tags: post.tags ?? [],
                                    onTap: ()=> context.push("/posts/detail/${post.id.toString()}"),
                                  );
                                }),
                              ),
                              SizedBox(height: 24,)
                            ],
                          )
                        )
                      )
                    ),
                    _buildAnimatedTabContent(
                       LeaderBoardScreen()
                    ),
                  ],
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}