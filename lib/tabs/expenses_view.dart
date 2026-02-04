import 'package:flutter/material.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("Expenses", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
