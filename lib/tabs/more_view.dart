import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text("More", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
