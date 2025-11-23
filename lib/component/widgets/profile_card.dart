import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isWide;
  final double? space;
  final double? titleSize;
  final bool? titleWeight;
  final double? valueSize;
  final bool? valueWeight;

  const ProfileCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isWide = false,
    this.space,
    this.titleSize,
    this.titleWeight = false,
    this.valueSize,
    this.valueWeight = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: isWide
          ? Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: space ?? 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize ?? 16,
                    color: Colors.grey[600],
                    fontWeight: titleWeight == true ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                SizedBox(height: space ?? 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: valueSize ?? 18,
                    fontWeight: valueWeight == true ? FontWeight.w700: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 35,
              ),
            ),
            SizedBox(height: space ?? 6),
            Text(
              title,
              style: TextStyle(
                fontSize: titleSize ?? 16,
                color: Colors.grey[600],
                fontWeight: titleWeight == true ? FontWeight.w700: FontWeight.w500,
                letterSpacing: -0.5
              ),
            ),
            SizedBox(height: space ?? 2),
            Text(
              value,
              style: TextStyle(
                fontSize: valueSize ?? 20,
                fontWeight: valueWeight == true ? FontWeight.w700:FontWeight.w500,
                color: Colors.black,
                letterSpacing: -0.5
              ),
            ),
          ],
        ),
    );
  }
}
