import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelected;

  const FilterChipWidget({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = option == selectedOption;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.w900: FontWeight.w700,
                fontSize: isSelected ? 16 : 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
