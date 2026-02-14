import 'package:flutter/material.dart';
import 'package:startup_expense_tracker/features/home/screens/home_screen.dart';
import 'package:startup_expense_tracker/features/team/screens/team_screen.dart';
import 'package:startup_expense_tracker/features/expenses/screens/expenses_screen.dart';
import 'package:startup_expense_tracker/features/ai/screens/ai_screen.dart';
import 'package:startup_expense_tracker/features/settings/screens/settings_screen.dart';
import 'package:startup_expense_tracker/widgets/custom_bottom_nav.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _getScreens() {
    return [
      HomeScreen(onNavigateToTab: _onTabSelected),
      const TeamScreen(),
      const ExpensesScreen(),
      const AiScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screens = _getScreens();
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: ModernDarkNavBar(
        onTabSelected: _onTabSelected,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
