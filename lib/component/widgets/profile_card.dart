import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  final bool isWide;
  final double spacing;
  final double titleSize;
  final FontWeight titleWeight;
  final double valueSize;
  final FontWeight valueWeight;

  const ProfileCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isWide = false,
    this.spacing = 8,
    this.titleSize = 16,
    this.titleWeight = FontWeight.w700,
    this.valueSize = 18,
    this.valueWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: isWide ? _buildWideLayout() : _buildColumnLayout(),
    );
  }

  // ----------------- UI: Layout ngang ------------------
  Widget _buildWideLayout() {
    return Row(
      children: [
        _buildIconBox(size: 40),
        SizedBox(width: spacing),
        Expanded(child: _buildTexts()),
      ],
    );
  }

  // ----------------- UI: Layout dọc ---------------------
  Widget _buildColumnLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min, // FIX overflow
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIconBox(size: 45),
        SizedBox(height: spacing),
        _buildTitle(),
        SizedBox(height: spacing / 2),
        _buildValue(),
      ],
    );
  }

  // ----------------- Reusable parts ---------------------

  Widget _buildIconBox({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: color, size: size * 0.7),
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(height: spacing / 2),
        _buildValue(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: TextStyle(
        fontSize: titleSize,
        fontWeight: titleWeight,
        color: const Color(0xFF0C2B3C),
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildValue() {
    return Text(
      value,
      style: TextStyle(
        fontSize: valueSize,
        fontWeight: valueWeight,
        color: const Color(0xFF374253),
        letterSpacing: -0.3,
      ),
    );
  }

  // ----------------- Decoration ---------------------
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
