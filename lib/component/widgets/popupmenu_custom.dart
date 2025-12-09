import 'package:flutter/material.dart';

class CustomPopupMenu extends StatefulWidget {
  final bool isOwner; // 🔥 kiểm tra user có phải chủ comment không
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;

  const CustomPopupMenu({
    super.key,
    required this.isOwner,
    this.onEdit,
    this.onDelete,
    this.onReport,
  });

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu>
    with SingleTickerProviderStateMixin {

  OverlayEntry? overlayEntry;

  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 220),
      vsync: this,
    );

    opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    slide = Tween(begin: const Offset(0, -0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  void showMenuOverlay() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // tap ra ngoài để đóng
          Positioned.fill(
            child: GestureDetector(
              onTap: hideMenu,
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned(
            top: offset.dy + box.size.height + 4,
            left: offset.dx - 140 + box.size.width,
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: opacity,
                child: SlideTransition(
                  position: slide,
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _buildMenuItems(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    controller.forward();
  }

  /// 🔥 Build menu item tùy theo quyền
  List<Widget> _buildMenuItems() {
    List<Widget> list = [];

    if (widget.isOwner) {
      list.add(_menuItem(Icons.edit, "Edit", widget.onEdit));
      list.add(_menuItem(Icons.delete, "Delete", widget.onDelete, color: Colors.red));
    }
    // Report luôn luôn có
    list.add(_menuItem(Icons.flag, "Report", widget.onReport));

    return list;
  }

  Widget _menuItem(IconData icon, String text, VoidCallback? callback, {Color? color}) {
    return InkWell(
      onTap: () {
        hideMenu();
        callback?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? Colors.black87),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: color ?? Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  void hideMenu() async {
    await controller.reverse();
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showMenuOverlay,
      child: const Icon(Icons.more_vert_rounded, size: 20,color: Colors.black54,),
    );
  }
}
