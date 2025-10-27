
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/forum_postcard.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/leader_board_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/post_detail_screen.dart';

class Community_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Community_Screen();
}
class _Community_Screen extends State<Community_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
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
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: (){},
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () => context.push('/community/post'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5
                ),
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              label: Text("Post",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                )
              ),
              icon: Icon(Icons.add,size: 28,color: Colors.white,),
            ),
            SizedBox(width: 10,),
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.all(20),
              child: TabBar(
                padding: EdgeInsets.all(10),
                controller: _tabController,
                labelColor: const Color(0xFF4F46E5),
                unselectedLabelColor: Colors.grey.shade500,
                labelStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700
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
            const SizedBox(height: 10),
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
                            children: List.generate(5, (index){
                              return ForumPostCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const PostDetailScreen(),
                                    ),
                                  );
                                },
                              );
                            }),
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
            )
          ],
        )
      ),
    );
  }
}