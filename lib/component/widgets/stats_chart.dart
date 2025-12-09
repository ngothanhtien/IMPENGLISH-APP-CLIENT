import 'package:flutter/material.dart';

class StatsChart extends StatelessWidget {
  final int correct;
  final int incorrect;
  final Animation<double> animation;

  const StatsChart({
    super.key,
    required this.correct,
    required this.incorrect,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final total = correct + incorrect;
    final correctPercentage = total > 0 ? correct / total : 0.0;
    final incorrectPercentage = total > 0 ? incorrect / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 12),

          // Correct Answers Bar
          _buildStatBar(
            'Correct Answers',
            correct,
            correctPercentage,
            const Color(0xFF10B981),
          ),
          const SizedBox(height: 16),

          // Incorrect Answers Bar
          _buildStatBar(
            'Incorrect Answers',
            incorrect,
            incorrectPercentage,
            const Color(0xFFEF4444),
          ),
          const SizedBox(height: 20),

          // Summary Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                'Total Questions',
                total.toString(),
                const Color(0xFF6366F1),
              ),
              _buildSummaryItem(
                'Accuracy',
                '${(correctPercentage * 100).toInt()}%',
                const Color(0xFF10B981),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int count, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage * animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
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
            fontSize: 14,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
