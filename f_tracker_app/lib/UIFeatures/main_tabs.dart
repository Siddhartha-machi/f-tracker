import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/screens/home_screen.dart';
import 'package:f_tracker_app/UIFeatures/models.dart';
import 'package:f_tracker_app/UIFeatures/atoms/custom_bottom_sheet.dart';
import 'package:f_tracker_app/UIFeatures/formatoms/add_workout_form.dart';
import 'package:f_tracker_app/UIFeatures/atoms/custom_button.dart';
import 'package:f_tracker_app/UIFeatures/formatoms/enum_dropdown.dart';

class UiEnchancedApp extends StatefulWidget {
  const UiEnchancedApp({super.key});

  @override
  State<UiEnchancedApp> createState() => _EnhancedFeatureState();
}

class _EnhancedFeatureState extends State<UiEnchancedApp> {
  List<CWorkoutActivity> activityItems = [
    CWorkoutActivity(
      exercise: 'Test',
      duration: 12,
      calories: 12,
      type: ActivityType.cardio,
      day: Weekday.friday,
      time: DayShift.evening,
    ),
    CWorkoutActivity(
      exercise: 'Test',
      duration: 12,
      calories: 12,
      type: ActivityType.flexibility,
      day: Weekday.saturday,
      time: DayShift.evening,
    ),
    CWorkoutActivity(
      exercise: 'Test',
      duration: 12,
      calories: 12,
      type: ActivityType.strength,
      day: Weekday.monday,
      time: DayShift.morning,
    ),
    CWorkoutActivity(
      exercise: 'Test',
      duration: 12,
      calories: 12,
      type: ActivityType.flexibility,
      day: Weekday.friday,
      time: DayShift.evening,
    ),
  ];

  Map<String, Enum> filters = {
    'filter-day': FilterWeekday.all,
    'filter-time': FilterDayShift.all
  };

  final formKey = GlobalKey<FormBuilderState>();
  final filtersFormKey = GlobalKey<FormBuilderState>();

  void addToActivityItems(CWorkoutActivity item) {
    setState(() {
      activityItems.add(item);
    });
  }

  void deleteActivityItem(CWorkoutActivity deleteItem) {
    setState(() {
      activityItems =
          activityItems.where((item) => deleteItem != item).toList();
    });
  }

  void setFiltersHandler(Map<String, Enum> newFilter) {
    setState(() {
      filters = newFilter;
    });
    Navigator.of(context).pop();
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

  _showFiltersDialog(BuildContext context) {
    applyFiltersHandler() {
      filtersFormKey.currentState?.save();
      setFiltersHandler({
        'filter-day':
            filtersFormKey.currentState?.fields['filter-day']?.value as Enum,
        'filter-time':
            filtersFormKey.currentState?.fields['filter-time']?.value as Enum,
      });
    }

    resetFiltersHandler() {
      setFiltersHandler(
        {
          'filter-day': FilterWeekday.all,
          'filter-time': FilterDayShift.all,
        },
      );
      // Navigator.of(context).pop();
    }

    showDialog(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: FormBuilder(
                key: filtersFormKey,
                initialValue: filters,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    EnumDropdown<FilterWeekday>(
                      label: 'Day',
                      options: FilterWeekday.values,
                      accessKey: 'filter-day',
                      formKey: filtersFormKey,
                    ),
                    const SizedBox(height: 12),
                    EnumDropdown<FilterDayShift>(
                      label: 'Time',
                      options: FilterDayShift.values,
                      accessKey: 'filter-time',
                      formKey: filtersFormKey,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtom(
                            label: 'Reset filters',
                            isFilled: true,
                            action: resetFiltersHandler,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButtom(
                            label: 'Apply filters',
                            isFilled: true,
                            action: applyFiltersHandler,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<CWorkoutActivity> get _filteredActivityItems {
    List<CWorkoutActivity> filteredList = activityItems;
    if (filters['filter-day'] != FilterWeekday.all) {
      filteredList = activityItems.where((item) {
        return item.day.name == filters['filter-day']!.name;
      }).toList();
    }
    if (filters['filter-time'] != FilterDayShift.all) {
      filteredList = filteredList
          .where((item) => item.time.name == filters['filter-time']!.name)
          .toList();
    }

    return filteredList;
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
        workoutItems: _filteredActivityItems,
        bottomSheetHandler: _showAddTrackerItemSheet,
        deleteHandler: deleteActivityItem,
        filtersHandler: () => _showFiltersDialog(context),
      ),
    );
  }
}
