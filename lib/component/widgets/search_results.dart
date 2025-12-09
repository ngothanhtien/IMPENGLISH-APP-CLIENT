import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/filter_dropdown.dart';
import 'package:learning_app_client/component/widgets/vocabulary_card.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';
import 'package:learning_app_client/service/vocabulary_service.dart';

class SearchResults extends StatefulWidget {
  final String query;

  const SearchResults({
    super.key,
    required this.query
  });
  @override
  State<StatefulWidget> createState() => _SearchResults();
}

class _SearchResults extends State<SearchResults>{
  CardVocabulary? cardVocabulary;
  List<IVocabBrief>? results;
  bool isLoading = false;
  String? error;
  int? totalVocabFind;
  Timer? _debounce;

  String selectedTopic = '';
  String selectedLevel = '';

  void _runDebounce(){
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search();   // gọi API sau khi dừng 400ms
    });
  }

  @override
  void didUpdateWidget(covariant SearchResults oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Khi query thay đổi → search lại
    if (oldWidget.query != widget.query) {
      _runDebounce();
    }
  }
  Future<void> _search() async {
    if(widget.query.trim().isEmpty) return;
    
    setState(() {
      isLoading = true;
    });
    
    try{
      final dataResponse = await VocabService().searchVocab(
        keyword: widget.query.toString(),
        topic: selectedTopic.toLowerCase().toString(),
        level: selectedLevel.toString()
      );
      setState(() {
        results = dataResponse.data;
        cardVocabulary = dataResponse;
        totalVocabFind = dataResponse.pagination?.total;
        isLoading = false;
        error = null;
      });
    }catch(e){
      setState(() {
        isLoading = false;
        error = e.toString();
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _search();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _debounce?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(child: CircularProgressIndicator(),);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Results for "${widget.query}"',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4)
                )
              ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Topic",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87
                        ),
                      ),
                      SizedBox(height: 8,),
                      FilterDropdown(
                        value: selectedTopic,
                        options: const [
                          '', 'Technology', 'Business', 'Education', 'Sports',
                          'Entertainment', 'Science', 'History',"General",
                        ],
                        onChanged: (value){
                          setState(() {
                            selectedTopic = value!;
                            _runDebounce();
                          });
                        },
                      ),
                    ],
                  )
                ),
                SizedBox(width: 10,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Level",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87
                          ),
                        ),
                        SizedBox(height: 8,),
                        FilterDropdown(
                          value: selectedLevel,
                          options: const [
                            '', "A1", "A2", "B1", "B2", "C1", "C2"
                          ],
                          onChanged: (value){
                            setState(() {
                              selectedLevel = value!;
                              _runDebounce();
                            });
                          },
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SearchResultList(
              isLoading: isLoading,
              error: error,
              results: results,
              total: totalVocabFind,
            ),
          ),
        ],
      ),
    );
  }
}
class SearchResultList extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<IVocabBrief>? results;
  final int? total;

  const SearchResultList({
    super.key,
    required this.isLoading,
    required this.error,
    required this.results,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if(results == null || results!.isEmpty || error != null){
      return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Not Found Any Vocabulary',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: total! > 10 ? 10 : total,
      padding: const EdgeInsets.all(4),
      itemBuilder: (context, index) {
        final item = results![index];
        return VocabularyCard(vocabularyWord: item);
      },
    );
  }
}
