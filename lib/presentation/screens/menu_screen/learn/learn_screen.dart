import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/filter_chip_widget.dart';
import 'package:learning_app_client/component/widgets/learning_progress_chart.dart';
import 'package:learning_app_client/component/widgets/search_input_field.dart';
import 'package:learning_app_client/component/widgets/vocabulary_card.dart';
import 'package:learning_app_client/model/flash_card.dart';
import 'package:learning_app_client/service/vocabularyService.dart';

class LearnScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LearnScreen();
}
class _LearnScreen extends State<LearnScreen>{
  final TextEditingController searchWordsController = TextEditingController();
  List<IVocabBrief> get_vocabCards = [];
  List<IVocabBrief> filter_vocabCards = [];
  bool isLoading = true;
  String filterSelected = "All";

  late TextEditingController _searchController;
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVocabCard();
    _searchController = TextEditingController();
  }

  Future<void> loadVocabCard () async {
    try{
      final result = await vocabService().fetchVocabBrief(limit: 20);
      setState(() {
        get_vocabCards = result.data ?? [];
        filter_vocabCards = get_vocabCards.where((v) => v.audio != null&& v.audio!.isNotEmpty).toList();
        isLoading = false;
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
      debugPrint("Error: $e");
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  List<IVocabBrief> dataMock = [
    IVocabBrief(
      id: "123",
      audio: "223312",
      word: "Hello",
      definition: "dsfdsfdsfdsfdsfdsfds",
      example: "123123124124",
      level: "C1",
      partOfSpeech: "ef/sd/fsd",
      pronunciation: "ádsfffffds",
      topic: "general"
    ),
    IVocabBrief(
        id: "124",
        audio: "223312",
        word: "Hello",
        definition: "dsfdsfdsfdsfdsfdsfds",
        example: "123123124124",
        level: "A1",
        partOfSpeech: "ef/sd/fsd",
        pronunciation: "ádsfffffds",
        topic: "general"
    ),
    IVocabBrief(
        id: "124",
        audio: "223312",
        word: "Hello",
        definition: "dsfdsfdsfdsfdsfdsfds",
        example: "123123124124",
        level: "B1",
        partOfSpeech: "ef/sd/fsd",
        pronunciation: "ádsfffffds",
        topic: "general"
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: Text("Vocabulary & Progress",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5
          ),
        ),
        leading: IconButton(
            onPressed: () => context.go('/home'),
            icon: Icon(Icons.arrow_back,size: 28,color: Colors.white,)
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color(0xFFE2E8F0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Progress",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 12,),
              const LearningProgressChart(),
              SizedBox(height: 20,),
              Text("Vocabulary Cards",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 12,),
              SearchInputField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _clearSearch,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: filter_vocabCards.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final vocab = filter_vocabCards[index];
                    return VocabularyCard(vocabularyWord: vocab,);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}