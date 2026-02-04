import 'package:flutter/material.dart';
import 'package:startup_expense_tracker/widgets/custom_bottom_nav.dart';
import 'package:startup_expense_tracker/tabs/home_tab.dart';
import 'package:startup_expense_tracker/tabs/expenses_view.dart';
import 'package:startup_expense_tracker/tabs/team_view.dart';
import 'package:startup_expense_tracker/tabs/insights_view.dart';
import 'package:startup_expense_tracker/tabs/more_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(), // Home
    const ExpensesView(), // Expenses
    const TeamView(), // Team
    const InsightsView(), // Insights
    const MoreView(), // More
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _screens),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNav(
              selectedIndex: _selectedIndex,
              onTabSelected: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}
