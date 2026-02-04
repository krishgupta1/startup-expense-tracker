import 'package:flutter/material.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("Insights", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
