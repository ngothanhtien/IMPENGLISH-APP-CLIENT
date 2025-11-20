import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/vocabulary_card.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';
import 'package:learning_app_client/service/vocabularyService.dart';

class SearchDetail_Screen extends StatefulWidget {
  final String topic;

  const SearchDetail_Screen({
    super.key,
    required this.topic
  });

  @override
  State<StatefulWidget> createState() => _SearchDetail_ScreenState();
}

class _SearchDetail_ScreenState extends State<SearchDetail_Screen> {
  List<IVocabBrief> vocabs = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = true;
  Timer? _debounce;

  String? selectedTopic;
  String? selectedLevel;

  Future<void> fetchVocabByTopic() async {
    setState(() {
      isLoading = true;
    });
    try{
      final response_data = await vocabService().fetchVocabBrief(
        topic: widget.topic.toString().toLowerCase(),

      );
      setState(() {
        vocabs = response_data.data ?? [];
        currentPage = response_data.pagination?.page ?? 0;
        totalPages = response_data.pagination?.pages ?? 0;
        isLoading = false;
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print("Error at List Vocab by topic!: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVocabByTopic();
  }

  Future<void> _onFilterChanged() async {
    // TODO: Gọi API search lại với filter + page = 1
    print("FILTER: $selectedTopic - $selectedLevel");
  }

  Future<void> _changePage(int newPage) async {
    if (newPage < 1 || newPage > totalPages) return;

    setState(() {
      currentPage = newPage;
    });

    try{
      final response_data = await vocabService().fetchVocabBrief(
        topic: widget.topic.toString().toLowerCase(),
        page: newPage
      );
      setState(() {
        currentPage = newPage;
        vocabs = response_data.data ?? [];
        totalPages = response_data.pagination?.pages ?? totalPages;
      });
    }catch(e){
      print("Error at fetch vocab changePage: $e");
    }
  }
  void _runDebounce(int newPage){
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _changePage(newPage);   // gọi API sau khi dừng 400ms
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: Text('Vocabulary By Topic: ${widget.topic}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18
          ),
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.arrow_back, size: 20, color: Colors.white,),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: vocabs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final vocab = vocabs[index];
                  return VocabularyCard(vocabularyWord: vocab);
                },
              ),
            ),

            // ---------------- PAGINATION ----------------------
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 4),
                    blurRadius: 10
                  )
                ],
                borderRadius: BorderRadius.circular(10)
              ),
              child: _buildPagination()
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    final isPrevDisabled = currentPage <= 1;
    final isNextDisabled = currentPage >= totalPages;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageButton(
            icon: Icons.navigate_before,
            disabled: isPrevDisabled,
            onPressed: () => _runDebounce(currentPage - 1),
          ),

          const SizedBox(width: 12),

          // ---- PAGE NUMBER INDICATOR ----
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF4F46E5),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4F46E5).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Text(
              "Page $currentPage / $totalPages",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 12),

          _buildPageButton(
            icon: Icons.navigate_next,
            disabled: isNextDisabled,
            onPressed: () => _runDebounce(currentPage + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton({
    required IconData icon,
    required bool disabled,
    required VoidCallback onPressed,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: disabled ? 0.4 : 1.0,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: disabled ? Colors.grey.shade200 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: disabled ? Colors.grey.shade300 : Colors.grey.shade400,
            ),
            boxShadow: disabled
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
      ),
    );
  }

}
