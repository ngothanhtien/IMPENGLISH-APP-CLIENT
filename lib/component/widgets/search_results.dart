import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/vocabulary_card.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';
import 'package:learning_app_client/service/vocabularyService.dart';

class SearchResults extends StatefulWidget {
  final String query;
  SearchResults({
    super.key,
    required this.query
  });
  @override
  State<StatefulWidget> createState() => _SearchResults();
}
class _SearchResults extends State<SearchResults>{
  List<IVocabBrief>? results;
  bool isLoading = false;
  String? error;
  int? total_vocab_find;

  @override
  void didUpdateWidget(covariant SearchResults oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Khi query thay đổi → search lại
    if (oldWidget.query != widget.query) {
      _search();
    }
  }
  Future<void> _search() async {
    if(widget.query.isEmpty) return;
    
    setState(() {
      isLoading = true;
    });
    
    try{
      final data_response = await vocabService().searchVocab(keyword: widget.query.toString());
      setState(() {
        results = data_response.data;
        total_vocab_find = data_response.pagination?.total;
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
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(child: CircularProgressIndicator(),);
    }
    if(results == null || results!.isEmpty || error != null){
      return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Not Found any vocabulary with keyword: "${widget.query}"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      );
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results for "${widget.query}"',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: total_vocab_find! > 10 ? 5 : total_vocab_find,
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final result = results?[index];
                  return VocabularyCard(
                      vocabularyWord: result!,
                  );
                },
              ),
            ),
            if(total_vocab_find! > 10)
              Center(
                child: TextButton(
                  onPressed: (){},
                  child: Text("See More >>",
                    style: TextStyle(
                      color: const Color(0xFF4F46E5),
                      fontSize: 15,
                    ),
                  )
                ),
              )
          ],
        ),
      ),
    );
  }
}