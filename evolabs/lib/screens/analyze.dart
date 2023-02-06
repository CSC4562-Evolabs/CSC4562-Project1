import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';

class Analyze extends StatefulWidget {
  const Analyze({super.key});

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        backgroundColor: backgroundColor2,
        title: const Padding(
          padding: EdgeInsets.only(
            top: 78.0,
            bottom: 15,
          ),
          child: Text(
            "Analysis",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
