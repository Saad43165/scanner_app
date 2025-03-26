import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/themes.dart';

class AnimatedNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 4,
      padding: EdgeInsets.zero,
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 0, "Home"),
            _buildNavItem(Icons.qr_code_scanner, 1, "Scan"),
            _buildNavItem(Icons.person, 2, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textDark,
              size: 28.0,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Text(
                label,
                key: ValueKey(label),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              )
                  : const SizedBox(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}