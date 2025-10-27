import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String> onSelected; // callback gửi giá trị được chọn

  const CategorySelector({
    Key? key,
    required this.categories,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with SingleTickerProviderStateMixin {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final categories = widget.categories;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // chia 2 hàng
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final item = categories[index];
        final bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() => selectedIndex = index);
            widget.onSelected(item['value']);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: Alignment.center,
            transformAlignment: Alignment.center,
            transform: isSelected
                ? (Matrix4.identity()..scale(1.02))
                : (Matrix4.identity()..scale(0.96)),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'],
                  color: isSelected ? Colors.white : item['color'],
                  size: isSelected ? 26 : 24,
                ),
                const SizedBox(width: 10),
                Text(
                  item['title'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
