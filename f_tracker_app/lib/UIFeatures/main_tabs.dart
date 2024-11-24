import 'package:flutter/material.dart';

import 'package:f_tracker_app/UIFeatures/screens/home_screen.dart';
import 'package:f_tracker_app/UIFeatures/models.dart';

class UiEnchancedApp extends StatefulWidget {
  const UiEnchancedApp({super.key});

  @override
  State<UiEnchancedApp> createState() => _EnhancedFeatureState();
}

class _EnhancedFeatureState extends State<UiEnchancedApp> {
  List<CWorkoutActivity> activityItems = [];

  void _showAddTrackerItemSheet(BuildContext ctx, {CWorkoutActivity? item}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FTrack',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () => _showAddTrackerItemSheet(context),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: HomeScreen(
        workoutItems: activityItems,
        bottomSheetHandler: _showAddTrackerItemSheet,
      ),
    );
  }
}
