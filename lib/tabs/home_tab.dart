import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("Expenses", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
