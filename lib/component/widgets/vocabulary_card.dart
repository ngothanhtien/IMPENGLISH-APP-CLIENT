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
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                              fontSize: 18,
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
                                fontSize: 14,
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
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Meaning: ",
                              style: TextStyle(
                                fontSize: 15,
                                color: const Color(0xFF475569),
                                fontWeight: FontWeight.w600
                              )
                            ),
                            TextSpan(text: '"${vocabularyWord.definition ?? ''}"',
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
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Part Of Speech: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: const Color(0xFF475569),
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    letterSpacing: -0.2
                                ),
                              ),
                              Text('${vocabularyWord.partOfSpeech ?? ''}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: const Color(0xFF475569),
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                  letterSpacing: -0.2,
                                ),
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Topic: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF475569),
                                      fontWeight: FontWeight.w600
                                  )
                                ),
                                TextSpan(text: '${vocabularyWord.topic ?? ''}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: const Color(0xFF475569),
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
                    icon: const Icon(Icons.edit, size: 22,color: Colors.white,),
                    label: const Text('Practice',
                      style: TextStyle(
                        fontSize: 16,
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
      ),
    );
  }
}
