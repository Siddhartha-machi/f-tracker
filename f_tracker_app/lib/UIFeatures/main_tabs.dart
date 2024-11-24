import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/screens/home_screen.dart';
import 'package:f_tracker_app/UIFeatures/models.dart';
import 'package:f_tracker_app/UIFeatures/atoms/custom_bottom_sheet.dart';
import 'package:f_tracker_app/UIFeatures/formatoms/add_workout_form.dart';

class UiEnchancedApp extends StatefulWidget {
  const UiEnchancedApp({super.key});

  @override
  State<UiEnchancedApp> createState() => _EnhancedFeatureState();
}

class _EnhancedFeatureState extends State<UiEnchancedApp> {
  List<CWorkoutActivity> activityItems = [];

  final formKey = GlobalKey<FormBuilderState>();

  void addToActivityItems(CWorkoutActivity item) {
    setState(() {
      activityItems.add(item);
    });
  }

  void _showAddTrackerItemSheet(BuildContext ctx, {CWorkoutActivity? item}) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          title: 'Add a workout activity',
          child: AddWorkoutForm(addToActivityItems, formKey),
        );
      },
    );
  }

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
