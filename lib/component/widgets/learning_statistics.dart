import 'package:flutter/material.dart';

class LearningStatistics extends StatelessWidget {
  final int correctAnswers;
  final int totalAttempts;
  final List<bool> exerciseResults;

  const LearningStatistics({
    super.key,
    required this.correctAnswers,
    required this.totalAttempts,
    required this.exerciseResults,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = totalAttempts > 0 ? correctAnswers / totalAttempts : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Practice Statistics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Correct',
                correctAnswers.toString(),
                const Color(0xFF10B981),
              ),
              _buildStatItem(
                'Total',
                totalAttempts.toString(),
                const Color(0xFF4F46E5),
              ),
              _buildStatItem(
                'Accuracy',
                '${(accuracy * 100).toInt()}%',
                const Color(0xFFF59E0B),
              ),
            ],
          ),
          if (exerciseResults.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              children: exerciseResults
                  .map((result) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: result
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(4),
                ),
              ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
