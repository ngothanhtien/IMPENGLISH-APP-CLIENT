import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/learning_progress_chart.dart';
import 'package:learning_app_client/component/widgets/vocabulary_card.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';
import 'package:learning_app_client/service/vocabulary_service.dart';

class LearnScreen extends StatefulWidget{
  const LearnScreen({super.key});
  @override
  State<StatefulWidget> createState() => _LearnScreen();
}
class _LearnScreen extends State<LearnScreen>{
  final TextEditingController searchWordsController = TextEditingController();
  List<IVocabBrief> getVocabCards = [];
  List<IVocabBrief> filterVocabCards = [];
  bool isLoading = true;

  late TextEditingController _searchController;

  Future<void> loadVocabCard () async {
    try{
      final result = await VocabService().fetchVocabBrief(
        limit: 10,
        topic: '',
        page: 1
      );
      setState(() {
        getVocabCards = result.data ?? [];
        filterVocabCards = getVocabCards.where((v) => v.audio != null&& v.audio!.isNotEmpty).toList();
        isLoading = false;
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
      debugPrint("Error: $e");
    }
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    loadVocabCard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: Text("Vocabulary & Progress",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5
          ),
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
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Text("Current Progress",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 12,),
              const LearningProgressChart(),
              SizedBox(height: 20,),
              Text("New Vocabulary",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 20,),
              isLoading ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: const Color(0xFF4F46E5),
                ),
              ):
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: filterVocabCards.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final vocab = filterVocabCards[index];
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