import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernDarkNavBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const ModernDarkNavBar({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Color(0xFF222222), width: 1.5),
        ),
      ),
      child: SafeArea(
        // FIX: Removed fixed height. 
        // Using vertical padding allows the widget to size itself naturally
        // preventing the "1 pixel overflow" error.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, "Home"),
              _buildNavItem(1, Icons.groups_rounded, Icons.groups_outlined, "Team"),
              _buildNavItem(2, Icons.receipt_long_rounded, Icons.receipt_long_outlined, "Expenses"),
              _buildNavItem(3, Icons.insights_rounded, Icons.insights_outlined, "AI"),
              _buildNavItem(4, Icons.settings_rounded, Icons.settings_outlined, "Settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
  ) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures it only takes needed space
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF222222) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? Colors.white : const Color(0xFF666666),
                size: 24, // Slightly adjusted for better fit
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : const Color(0xFF666666),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}