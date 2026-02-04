import 'package:flutter/material.dart';

class TeamView extends StatelessWidget {
  const TeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("Team", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
