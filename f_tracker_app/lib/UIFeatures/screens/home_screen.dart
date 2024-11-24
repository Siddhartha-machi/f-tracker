import 'package:f_tracker_app/UIFeatures/models.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.bottomSheetHandler,
    required this.workoutItems,
  });

  final void Function(BuildContext, {CWorkoutActivity? item})
      bottomSheetHandler;
  final List<CWorkoutActivity> workoutItems;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
