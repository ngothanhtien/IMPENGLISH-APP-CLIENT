import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/audio/custom_audio_widget.dart';
import 'package:learning_app_client/model/vocabulary/flash_card.dart';

class VocabularyCard extends StatelessWidget {
  final IVocabBrief vocabularyWord;

  const VocabularyCard({
    super.key,
    required this.vocabularyWord,
  });

  Color _getLevelColor(String level) {
    switch (level) {
      case 'A1':
      case 'A2':
        return const Color(0xFF10B981);
      case 'B1':
      case 'B2':
      case 'Intermediate':
        return const Color(0xFFF59E0B);
      case 'C1':
      case 'C2':
      case 'Advanced':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF64748B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          vocabularyWord.word ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getLevelColor(vocabularyWord.level ?? '').withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            vocabularyWord.level ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getLevelColor(vocabularyWord.level ?? ''),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        AudioPlayerWidget(url: vocabularyWord.audio ?? '')
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Meaning: ",
                            style: TextStyle(
                              fontSize: 17,
                              color: const Color(0xFF475569),
                              fontWeight: FontWeight.w600
                            )
                          ),
                          TextSpan(text: '"${vocabularyWord.definition ?? ''}"',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF64748B),
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                              letterSpacing: -0.2,
                            )
                          ),
                        ]
                      )
                    ),
                    const SizedBox(height: 12,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Part Of Speech: ",
                            style: TextStyle(
                                fontSize: 17,
                                color: const Color(0xFF475569),
                                fontWeight: FontWeight.w600
                            )
                          ),
                          TextSpan(text: '${vocabularyWord.partOfSpeech ?? ''}',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF64748B),
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                              letterSpacing: -0.2,
                            )
                          ),
                        ]
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: ()=> context.push('/learning/practice/${vocabularyWord.id.toString()}'),
                  icon: const Icon(Icons.edit, size: 24,color: Colors.white,),
                  label: const Text('Practice',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    side: const BorderSide(color: Color(0xFF4F46E5)),
                    padding: EdgeInsets.symmetric(
                      vertical: 12
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
