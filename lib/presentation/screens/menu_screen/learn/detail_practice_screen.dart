import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/audio/custom_audio_widget.dart';
import 'package:learning_app_client/component/record/CustomRecord.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';
import 'package:learning_app_client/model/vocabulary/vocab_detail.dart';
import 'package:learning_app_client/service/vocabularyService.dart';

class DetailPracticeScreen extends StatefulWidget {
  final String vocab_id;

  const DetailPracticeScreen({super.key, required this.vocab_id});

  @override
  State<StatefulWidget> createState() => _DetailPracticeScreen();
}

class _DetailPracticeScreen extends State<DetailPracticeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentStep = 0;
  bool _isloading = true;
  bool _isRecorded = false;
  IVocabDetail? vocab;

  Future<IVocabDetail> fetchDetailVocab() async {
    try {
      final vocabDetail =
      await vocabService().fetchVocabDetail(id: widget.vocab_id);

      return vocabDetail.detail!;
    } catch (e) {
      throw Exception("Failed fetch detail vocab: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    fetchDetailVocab();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        title: const Text(
          'Vocabulary Practice',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.bookmark_border,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<IVocabDetail>(
        future: fetchDetailVocab(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if(!snapshot.hasData) {
            return const Center(child: Text("No data"),);
          }
          final vocab = snapshot.data!;
          return SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildProgressIndicator(),
                        const SizedBox(height: 24),
                        _buildVocabularyCard(vocab),
                        const SizedBox(height: 24),
                        _buildWordDetails(vocab),
                        const SizedBox(height: 24),
                        _buildPracticeSteps(),
                        const SizedBox(height: 24),
                        _buildRecordSection(),
                        const SizedBox(height: 24),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school,
              color: Color(0xFF4F46E5),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Practice Progress',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: const Color(0xFFDEE6ED),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
                  borderRadius: BorderRadius.circular(8),
                  minHeight: 5,
                ),
                const SizedBox(height: 4),
                const Text(
                  '3 of 5 steps completed',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyCard(IVocabDetail vocab) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F46E5), Color(0xFF764BA2)],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF764BA2).withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vocab?.level ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.star_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            vocab?.word ?? '',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            vocab?.phonetics?[0].text ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: AudioPlayerWidget(
              url: vocab?.phonetics?[0].audio ?? '',
              inactiveColor: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordDetails(IVocabDetail vocab) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.book_outlined,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Definition',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Meaning: ",
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF475569),
                    fontWeight: FontWeight.w600
                  )
                ),
                TextSpan(text: '"${vocab?.meanings?[0].definitions?[0].definition ?? ''}"',
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF525E71),
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    letterSpacing: -0.2,
                  )
                ),
              ]
            )
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "MeaningVN: ",
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF475569),
                    fontWeight: FontWeight.w600
                  )
                ),
                TextSpan(text: '"${vocab?.meaningVN ?? ''}"',
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF525E71),
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    letterSpacing: -0.2,
                  )
                ),
              ]
            )
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Part Of Speech: ",
                  style: TextStyle(
                      fontSize: 15,
                      color: const Color(0xFF475569),
                      fontWeight: FontWeight.w600
                  )
                ),
                TextSpan(text: '${vocab?.meanings?[0].partOfSpeech?? ''}',
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF525E71),
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    letterSpacing: -0.2,
                  )
                ),
              ]
            )
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.2),width: 1.2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Example:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"${vocab?.meanings?[0].definitions?[0].example ?? ''}"',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF525E71),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeSteps() {
    final steps = [
      {'title': 'Listen', 'icon': Icons.headphones, 'completed': true},
      {'title': 'Read', 'icon': Icons.visibility, 'completed': true},
      {'title': 'Practice', 'icon': Icons.mic, 'completed': false},
      {'title': 'Review', 'icon': Icons.check_circle_outline, 'completed': false},
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Steps',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: steps.map((step) {
              final index = steps.indexOf(step);
              final isCompleted = step['completed'] as bool;
              final isActive = index == 2; // Current step

              return Expanded(
                child: Column(
                  children: [
                    Badge(
                      label: Icon(
                        Icons.check_circle,
                        size: 24,
                        color: isCompleted ? Colors.green:
                        Colors.black.withOpacity(0.15),
                      ),
                      alignment: Alignment(0.5,-0.9),
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? const Color(0xFF10B981)
                              : isActive
                              ? const Color(0xFF667EEA)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isCompleted || isActive
                                ? Colors.transparent
                                : const Color(0xFFE2E8F0),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          step['icon'] as IconData,
                          color: isCompleted || isActive
                              ? Colors.white
                              : const Color(0xFF94A3B8),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.2,
                        color: isCompleted || isActive
                            ? const Color(0xFF1E293B)
                            : const Color(0xFF94A3B8),
                        height: 1.1
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.mic,
                  color: Color(0xFFEF4444),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Record Your Pronunciation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Tap and hold the microphone to record your pronunciation. We\'ll help you improve!',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF64748B),
              height: 1.4,
              fontStyle: FontStyle.italic
            ),
          ),
          const SizedBox(height: 20),
          RecorderScreen(),
          if (_isRecorded) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF10B981),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Great job! Your pronunciation sounds good.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isRecorded = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_forward, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Continue to Next Word',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Skip this word',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}