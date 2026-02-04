import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const CustomBottomNav({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black],
          stops: [0.0, 0.5],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.only(bottom: 10),
            color: AppTheme.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.grid_view_outlined, "Home"),
                _buildNavItem(1, Icons.receipt_long_outlined, "Expenses"),
                const SizedBox(width: 60), // Space for center button
                _buildNavItem(
                  3,
                  Icons.insights,
                  "Insights",
                ), // Replaced 'AI' icon with clean chart
                _buildNavItem(4, Icons.menu, "More"),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            child: GestureDetector(
              onTap: () => onTabSelected(2),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: selectedIndex == 2
                      ? const LinearGradient(
                          colors: [Color(0xFF444444), Color(0xFF111111)],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFF2C2C2C), Color(0xFF000000)],
                        ),
                  border: Border.all(color: Colors.white12, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.groups_outlined, // Team Icon
                    color: selectedIndex == 2 ? Colors.white : Colors.white70,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white24,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white24,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
