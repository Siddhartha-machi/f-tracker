import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, required this.title, required this.child});

  final Widget child;
  final String title;

  final double _padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final dynamcPadding = MediaQuery.of(context).viewInsets.vertical;
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: _padding,
        left: _padding,
        right: _padding,
        bottom: dynamcPadding > 0 ? dynamcPadding + _padding : 35,
      ),
      child: Card(
        elevation: 24,
        child: Container(
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: [Colors.white, Colors.white]),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            child
          ]),
        ),
      ),
    );
  }
}
